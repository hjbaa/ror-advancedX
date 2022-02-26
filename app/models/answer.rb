# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  before_destroy :destroy_attached_files

  def best?
    id == question.best_answer_id
  end

  def best_for?(given_question)
    id == given_question.best_answer_id
  end

  private

  def destroy_attached_files
    files.each(&:purge)
  end
end
