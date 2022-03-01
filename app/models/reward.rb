# frozen_string_literal: true

class Reward < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  has_one_attached :image

  before_destroy :destroy_attached_image

  validates :name, presence: true

  private

  def destroy_attached_image
    image.purge
  end
end
