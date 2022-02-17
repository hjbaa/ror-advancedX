# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'

  belongs_to :best_answer, class_name: 'Answer', optional: true

  validates :body, :title, presence: true

  def answers_without_best
    answers if best_answer.nil?

    tmp = []
    answers.each do |answer|
      next if answer == best_answer

      tmp << answer
    end
    tmp
  end
end
