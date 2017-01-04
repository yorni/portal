class Institution < ActiveRecord::Base
  belongs_to :branch

  has_many :receipts
end
