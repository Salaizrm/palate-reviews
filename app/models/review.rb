class Review < ActiveRecord::Base
  belongs_to :users
  validates :title, presence: true
  validates :rating, presence: true
  validates :content, presence: true
end
