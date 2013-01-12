class Tenderer < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tender_infos
  has_many :procurements, :through => :tender_infos

  def update_counters!
    self.tender_infos_count = self.tender_infos.count
    self.winning_tender_infos_count = self.tender_infos.winning.count
    self.save
  end
end
