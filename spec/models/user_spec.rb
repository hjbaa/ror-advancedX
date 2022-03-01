# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:rewards) }
  end

  describe 'Methods' do
    describe 'author_of?' do
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

    describe 'assign_reward' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, author: user) }
      let!(:reward) { create(:reward, question: question) }

      it 'Should show that rewards list of new user is empty' do
        expect(user.rewards).to eq []
      end

      it 'Should add reward to user rewards' do
        user.assign_reward(reward)
        expect(user.rewards).to eq [reward]
      end

      it 'Should take away reward from user' do
        user.assign_reward(reward)
        user.assign_reward(reward)
        user.reload
        expect(user.rewards).to eq []
      end
    end
  end
end
