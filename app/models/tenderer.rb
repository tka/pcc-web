class Tenderer < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tender_infos
  has_many :procurements, :through => :tender_infos
end
