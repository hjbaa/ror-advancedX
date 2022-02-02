class AnswersController < ApplicationController
  before_action :find_answer, only: %i[update destroy]

  def create

  end

  def update

  end

  def destroy

  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
