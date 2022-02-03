class AnswersController < ApplicationController
  before_action :find_answer, only: %i[update destroy]

  # идея для вьюшек - сделать что-то на подобии stackoverflow, т.е. чтобы на одной странице можно было увидеть сразу
  # кнопки для редактирования ответа (там же редактировать), удаления и добавления ответа. Причем форма добавления
  # ответа показывается сразу и никуда не убирается
  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.new(answer_params)

    if @answer.save
      flash[:success] = 'Answer was created!'
    else
      flash[:danger] = 'Invalid input!'
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:success] = 'Answer was created!'
    else
      flash[:danger] = 'Invalid input!'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer was destroyed!'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
