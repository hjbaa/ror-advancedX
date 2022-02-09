# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.created_questions.new
  end

  def create
    @question = current_user.created_questions.new(question_params)

    if @question.save
      flash[:success] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.author == current_user
      if @question.update(question_params)
        flash[:success] = 'Your question successfully updated.'
        redirect_to @question
      else
        render :edit
      end
    else
      flash[:danger] = 'You are not allowed to do this!'
      redirect_to @question
    end
  end

  def destroy
    if @question.author == current_user
      @question.destroy
      flash[:success] = 'Your question successfully destroyed.'
    else
      flash[:danger] = 'You are not allowed to do this!'
    end

    redirect_to questions_path
  end

  def edit; end

  def show; end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
