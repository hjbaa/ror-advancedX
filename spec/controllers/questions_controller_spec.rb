# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'should populate an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'should render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'should assign the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'should assign a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'should render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'Valid attributes' do
      it 'should save a new question to database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'should redirect to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'Invalid attributes' do
      it 'should not save a new question to database' do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid) }
        end.to_not change(Question, :count)
      end

      it 'should rerender new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    describe 'Author' do
      before { login(user) }

      context 'Valid attributes' do
        it 'should assign the requested question to @question' do
          patch :update, params: { id: question, question: attributes_for(:question), format: :js }
          expect(assigns(:question)).to eq question
        end

        it 'should change question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
          question.reload

          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'should redirect to updated question' do
          patch :update, params: { id: question, question: attributes_for(:question), format: :js }
          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'Invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid), format: :js } }

        it 'should not change question attributes' do
          question.reload

          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 'should rerender edit view' do
          expect(response).to render_template :update
        end
      end
    end

    describe 'Not author' do
      it 'should not change question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, author: user) }

    describe 'Author' do
      before { login(user) }

      it 'should delete the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'should redirect to index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    describe 'Not author' do
      it 'should not delete the question' do
        expect { delete :destroy, params: { id: question } }.not_to change(Question, :count)
      end
    end
  end

  describe 'POST #mark_best_answer' do
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, question: question, author: user) }

    describe 'Author' do
      before { login(user) }

      it 'should not assign @question to question' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        expect(assigns(:question)).to eq question
      end

      it 'should not assign @answer to answer' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        expect(assigns(:answer)).to eq answer
      end

      it 'should assign best answer for question' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        expect(assigns(:question).best_answer).to eq answer
      end

      it 'should assign nil to best_answer' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        expect(assigns(:question).best_answer).to be_nil
      end

      it 'should render mark_best_answer template' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }
        expect(response).to render_template :mark_best_answer
      end
    end

    describe 'Not author' do
      it 'should not assign best answer to question' do
        post :mark_best_answer, params: { id: question.id, answer_id: answer.id, format: :js }

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
