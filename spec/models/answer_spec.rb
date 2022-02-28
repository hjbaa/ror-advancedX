# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Associations' do
    it { should belong_to(:question) }
    it { should belong_to(:author) }
  end

  describe 'Validations' do
    it { should validate_presence_of :body }
    it 'should have many attached file' do
      expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe 'Methods' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:first_answer) { create(:answer, question: question, author: user) }
    let!(:second_answer) { create(:answer, question: question, author: user) }
  end
end
