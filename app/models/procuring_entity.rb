class ProcuringEntity < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :procurements
end
