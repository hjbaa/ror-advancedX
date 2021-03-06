# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy mark_best_answer]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
    @question.links.new
    @reward = Reward.new(question: @question)
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      flash[:success] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    return head(:forbidden) unless current_user.author_of?(@question)

    @question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:success] = 'Your question successfully destroyed.'
    else
      flash[:danger] = 'You are not allowed to do this!'
    end

    redirect_to questions_path
  end

  def show
    @answer = Answer.new
    @answer.links.new
  end

  def mark_best_answer
    return head(:forbidden) unless current_user&.author_of?(@question)

    @answer = Answer.find(params[:answer_id])

    if @answer.best_for?(@question)
      @question.update(best_answer: nil)
    else
      @question.update(best_answer: @answer)
    end

    @answer.author.assign_reward(@question.reward) if @question.reward
  end

  private

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                                    links_attributes: %i[name url],
                                                    reward_attributes: %i[name image])
  end
end
