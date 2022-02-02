require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    context 'Valid attributes' do
      it 'should save a new answer to database as child element for question' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }
          .to change(question.answers, :count).by(1)
      end
    end

    context 'Invalid attributes' do
      it 'should not save a new answer to database' do
        expect do
          post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        end.to_not change(question.answers, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'Valid attributes' do
      it 'should assign the requested answer to @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'should change answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }
        answer.reload

        expect(answer.body).to eq 'new body'
      end
    end

    context 'Invalid attributes' do
      it 'should not change answer attributes' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }
        answer.reload

        expect(answer.body).to eq 'MyString'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question) }

    it 'should delete the question' do
      expect { delete :destroy, params: { id: answer } }.to change(question.answers, :count).by(-1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
