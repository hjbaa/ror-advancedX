# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_questions, class_name: 'Question', foreign_key: 'author_id', dependent: :destroy
  has_many :created_answers, class_name: 'Answer', foreign_key: 'author_id', dependent: :destroy

  # TODO: добавить стили к девайсовским вьюшкам
end
