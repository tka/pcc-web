class Procurement < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tender_infos
  has_many :tenderers, :through => :tender_infos
  belongs_to :procuring_entity
  def entity_name
    procuring_entity.name
  end
end
