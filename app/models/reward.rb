class Reward < ApplicationRecord
  belongs_to :question

  has_and_belongs_to_many :users

  has_one_attached :images
end
