# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Associations' do
    it { should have_many(:answers) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to(:best_answer).optional(true) }
    it { should belong_to(:author) }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  describe 'Methods' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:first_answer) { create(:answer, question: question, author: user) }
    let!(:second_answer) { create(:answer, question: question, author: user) }

    describe 'answers_without_best' do
      it 'should return list of all answers' do
        p question.answers_without_best.inspect
        expect(question.answers_without_best).to eq question.answers
      end

      it 'should return list of one answer' do
        question.update(best_answer: first_answer)
        expect(question.answers_without_best).to eq [second_answer]
      end
    end
  end
end
