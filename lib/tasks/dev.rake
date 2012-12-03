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
    Dir.glob(File.join(args[:source_folder], '*')) do |source_json|
      json=JSON.load(open(source_json))
      entity_name = json["機關資料"]["機關名稱"]
      entity_subname = json["機關資料"]["單位名稱"]
      entity_name = entity_name == entity_subname ? entity_name : "#{entity_name}-#{entity_subname}"
      puts (entity_name == entity_subname).inspect
      entity = ProcuringEntity.find_or_create_by_entity_code({
        :entity_code => json["機關資料"]["機關代碼"], 
        :name => entity_name
      })
      procurement_data = json["採購資料"] || json["已公告資料"]
      procurement = entity.procurements.find_or_create_by_job_number({
        :job_number => procurement_data["標案案號"],
        :subject => procurement_data["標案名稱"],
        :price => json["決標資料"]["總決標金額"].gsub(/[^\d]/,'').to_i,
        :finish_at => Date.parse(json["決標資料"]["決標日期"]) + 1911.years
      })
      json["投標廠商"]["投標廠商"].each do |t|
        tenderer = Tenderer.find_or_create_by_business_number({
          :business_number => t["廠商代碼"],
          :name => t["廠商名稱"]
        })
        TenderInfo.create({
          :procurement_id => procurement.id,
          :tenderer_id => tenderer.id,
          :winning => t["是否得標"]== "是",
          :price => t["決標金額"]&&t["決標金額"].gsub(/[^\d]/,'').to_i
        })
      end

    end
  end
end
