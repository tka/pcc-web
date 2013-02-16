# -*- encoding : utf-8 -*-
namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "demo"
  task :demo => :environment do
  end

  desc "import"
  task :import, [:source_folder] => [:environment] do |t, args|
    puts args
    all_files = Dir.glob(File.join(args[:source_folder]))
    puts all_files.length
    puts args[:source_json]
    #ActiveRecord::Base.connection.disconnect! 
    procs = [] 
    4.times do |x|
      length = (all_files.length/4).ceil
      files=all_files[length*x..length*(x+1)]
      procs << proc do
        ActiveRecord::Base.establish_connection
        files.each_with_index do |source_json, index|
          puts "#{index}/#{files.count} #{source_json}"
          ActiveRecord::Base.transaction do
            json=JSON.load(open(source_json))

            if json["投標廠商"]["投標廠商"].is_a? String
              puts "標案資料不相容, 請檢查標案資料"
              next
            end
            if !json["機關資料"]
              puts "標案資料不相容, 請檢查標案資料"
              next
            end

            entity_name = json["機關資料"]["機關名稱"]
            entity_subname = json["機關資料"]["單位名稱"]
            entity_name = entity_name == entity_subname ? entity_name : "#{entity_name}-#{entity_subname}"
            entity = ProcuringEntity.find_or_create_by_entity_code({
              :entity_code => json["機關資料"]["機關代碼"], 
              :name => entity_name
            })
            procurement_data = json["採購資料"] || json["已公告資料"]
            next if entity.procurements.where(:job_number => procurement_data["標案案號"]).exists?
            procurement = entity.procurements.create({
              :job_number => procurement_data["標案案號"],
              :subject => procurement_data["標案名稱"],
              :price => json["決標資料"]["總決標金額"].to_i, 
              :finish_at => json["決標資料"]["決標日期"],
              :url => json["url"]
            })
            tenderers =[]
            json["投標廠商"]["投標廠商"].each_with_index do |t, index|
              tenderer = Tenderer.find_or_create_by_business_number_and_name({
                :business_number => t["廠商代碼"],
                :name => t["廠商名稱"]
              })
              tenderers << tenderer
            end

            json["決標品項"]["品項"].each_with_index do |item,index|
              if item["得標廠商"]
                item["得標廠商"].each_with_index do |data, i|
                  tenderer = tenderers.find{|x| x.name == data["得標廠商"]}
                  begin
                    TenderInfo.create({
                      :procurement_id => procurement.id,
                      :tenderer_id => tenderer.id,
                      :winning => true,
                      :price => data["決標金額"].to_i
                    })
                  rescue
                    puts tenderers.inspect
                    puts data["得標廠商"]
                  end
                end 
              end 
              if item["未得標廠商"]
                item["未得標廠商"].each_with_index do |data, i|
                  tenderer = tenderers.find{|x| x.name == data["未得標廠商"]}
                  begin
                    TenderInfo.create({
                      :procurement_id => procurement.id,
                      :tenderer_id => tenderer.id,
                      :winning => false,
                      :price => 0
                    })
                  rescue
                    puts tenderers.inspect
                    puts data["未得標廠商"]
                  end
                end 
              end 
            end
          end
        end
      end
    end
    procs.each do |p|
      fork{p.call}
    end
    Process.waitall
    Tenderer.find_each{|t| t.update_counters!}
  end
end
