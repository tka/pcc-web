class TenderInfo < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :procurement
  belongs_to :tenderer
end
