# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_and_belong_to_many :rewards }
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
end
