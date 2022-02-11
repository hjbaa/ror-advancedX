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
    let(:first_question) { create(:question, author: first_user) }
    let(:second_question) { create(:question, author: second_user) }

    it 'Should show that first user is author of first question' do
      expect(first_user.author_of?(first_question)).to be_truthy
    end

    it 'Should show that first user is not author of second question' do
      expect(first_user.author_of?(second_question)).to be_falsey
    end

    it 'Should show that second user is author of second question' do
      expect(second_user.author_of?(second_question)).to be_truthy
    end
  end
end
