# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def best?
    id == question.best_answer_id
  end

  def best_for?(given_question)
    id == given_question.best_answer_id
  end

  # написано 2 метода, т.к. возникают проблемы, когда пользователь отмечает вопрос лучшим. Конкретно:
  # Если использовать только метод best? везде, то отмеченный вопрос ставится в списке первым
  # как нужно (отрабатывает js), но стили, которые прописаны в _answer.html.slim не работают (они тоже зависят от best?).
  # Насколько я понял, как это работает: questions_controller вызывает best?, он возвращает false и рельса это
  # "запоминает" и использует false для последующих вызовов этого метода внутри _answer.html.slim
end
