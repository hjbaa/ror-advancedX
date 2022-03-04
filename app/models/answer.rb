# frozen_string_literal: true

class Answer < ApplicationRecord
  include Attachable
  include Votable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, :rating, presence: true

  def best?
    id == question.best_answer_id
  end

  def best_for?(given_question)
    id == given_question.best_answer_id
  end
end
