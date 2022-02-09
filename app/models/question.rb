# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User', optional: true

  validates :body, :title, presence: true
end
