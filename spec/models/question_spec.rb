# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Associations' do
    it { should belong_to(:best_answer).optional(true) }
    it { should belong_to(:author) }

    it { should have_many(:answers) }
    it { should have_many(:links).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_one(:reward) }

    it 'should have many attached file' do
      expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }

    it { should accept_nested_attributes_for :links }
    it { should accept_nested_attributes_for :reward }
  end

  describe 'Methods' do
    describe 'answers_without_best' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, author: user) }
      let!(:first_answer) { create(:answer, question: question, author: user) }
      let!(:second_answer) { create(:answer, question: question, author: user) }

      it 'should return list of all answers' do
        expect(question.answers_without_best).to eq question.answers
      end

      it 'should return list of one answer' do
        question.update(best_answer: first_answer)
        expect(question.answers_without_best).to eq [second_answer]
      end
    end
  end
end
