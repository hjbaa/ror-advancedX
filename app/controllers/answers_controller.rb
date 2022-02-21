# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[update destroy destroy_attachment]

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

  def destroy_attachment
    return head(:forbidden) unless current_user&.author_of?(@answer)

    @attached_file = ActiveStorage::Attachment.find(params[:attachment_id])
    @attached_file.purge
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end
end
