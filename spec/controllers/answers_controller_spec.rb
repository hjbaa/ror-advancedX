require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    context 'Valid attributes' do
      it 'should save a new answer to database'
      it 'should create child element for question in @answer'
      it 'should redirect to show view'
    end

    context 'Invalid attributes' do
      it 'should not save a new answer to database'
      it 'should rerender new view'
    end
  end

  describe 'PATCH #update' do
    context 'Valid attributes' do
      it 'should assign the requested answer to @answer'
      it 'should change answer attributes'
      it 'should redirect to updated answer'
    end

    context 'Invalid attributes' do
      it 'should not change answer attributes'
      it 'should rerender edit view'
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the question'
    it 'should redirect to parent question for answer'
  end
end
# rubocop:enable Metrics/BlockLength
