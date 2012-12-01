class Procurement < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tender_infos
  has_many :tenderers, :through => :tender_infos
end
