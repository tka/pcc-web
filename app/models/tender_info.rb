class TenderInfo < ActiveRecord::Base
  # attr_accessible :title, :body
  scope :winning, where(:winning => true)
  belongs_to :procurement
  belongs_to :tenderer
end
