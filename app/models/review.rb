class Review < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :brand, presence: true
  validates :type, presence: true
  validates :rating, presence: true
  validates :content, presence: true
end
