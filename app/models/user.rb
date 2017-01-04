class User < ActiveRecord::Base
  has_secure_password   
  belongs_to :institution
  belongs_to :supplier
  validates :username, presence: true
  validates :username, uniqueness: true
end
