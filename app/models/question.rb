# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files

  validates :body, :title, presence: true

  def answers_without_best
    answers.where.not(id: best_answer_id)
  end
end
