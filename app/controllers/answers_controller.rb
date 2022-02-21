# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[update destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(author: current_user))
  end

  def update
    return head(:forbidden) unless current_user.author_of?(@answer)

    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    return head(:forbidden) unless current_user.author_of?(@answer)

    @question = @answer.question
    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
