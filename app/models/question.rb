# frozen_string_literal: true

class Question < ApplicationRecord
  include Attachable
  include Votable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: proc { |attributes|
                                                      attributes['name'].blank? || attributes['image'].blank?
                                                    }

  validates :body, :rating, :title, presence: true

  def answers_without_best
    answers.where.not(id: best_answer_id)
  end
end
