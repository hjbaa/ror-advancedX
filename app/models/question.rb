# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: proc { |attributes| attributes['name'].blank? || attributes['image'].blank? }

  validates :body, :title, presence: true

  before_destroy :destroy_attached_files

  def answers_without_best
    answers.where.not(id: best_answer_id)
  end

  private

  def destroy_attached_files
    files.each(&:purge)
  end
end
