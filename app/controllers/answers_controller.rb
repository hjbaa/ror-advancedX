class AnswersController < ApplicationController
  before_action :find_answer, only: %i[edit update destroy]

  def edit; end

  def new

  end

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
