# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }

  describe 'POST #create' do
    before { login(user) }

    context 'Valid attributes' do
      it 'should save a new answer to database as child element for question' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js }
          .to change(question.answers, :count).by(1)
      end

      it 'should render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'Invalid attributes' do
      it 'should not save a new answer to database' do
        expect do
          post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js }
        end.to_not change(Answer, :count)
      end

      it 'should render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    describe 'Author' do
      before { login(user) }

      context 'Valid attributes' do
        it 'should assign the requested answer to @answer' do
          patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
          expect(assigns(:answer)).to eq answer
        end

        it 'should change answer attributes' do
          patch :update, params: { id: answer, answer: { body: 'new body' }, format: :js }
          answer.reload

          expect(answer.body).to eq 'new body'
        end

        it 'should render update template' do
          patch :update, params: { id: answer, answer: { body: 'new body' }, format: :js }
          expect(response).to render_template :update
        end
      end

      context 'Invalid attributes' do
        it 'should not change answer attributes' do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid), format: :js }
          answer.reload

          expect(answer.body).to eq 'MyStringForAnswer'
        end

        it 'should render update template' do
          patch :update, params: { id: answer, answer: { body: 'new body' }, format: :js }
          expect(response).to render_template :update
        end
      end
    end

    describe 'Not author' do
      it 'should not change answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }
        answer.reload

        expect(answer.body).to eq 'MyStringForAnswer'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, author: user) }

    describe 'Author' do
      before { login(user) }

      it 'should delete the question' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'should redirect to question' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question
      end
    end

    describe 'Not author' do
      it 'should not delete the question' do
        expect { delete :destroy, params: { id: answer } }.not_to change(Answer, :count)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
