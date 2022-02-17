# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'Methods' do
    let(:first_user) { create(:user) }
    let(:second_user) { create(:user) }
    let(:question) { create(:question, author: first_user) }

    it 'Should show that first user is author of first question' do
      expect(first_user).to be_author_of(question)
    end

    it 'Should show that second user is not author of first question' do
      expect(second_user).not_to be_author_of(question)
    end
  end

  describe 'Methods' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:first_answer) { create(:answer, question: question, author: user) }
    let!(:second_answer) { create(:answer, question: question, author: user) }

    describe 'answers_without_best' do
      it 'should return list of all answers' do
        expect(question.answers_without_best).to eq [first_answer, second_answer]
      end

      it 'should return list of one answer' do
        question.update(best_answer: first_answer)
        expect(question.answers_without_best).to eq [second_answer]
      end
    end
  end
end
