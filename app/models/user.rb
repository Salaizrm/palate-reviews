class User < ActiveRecord::Base
  include Slugafiable::InstanceMethods
  extend Slugafiable::ClassMethods
  has_secure_password
  has_many :reviews
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
