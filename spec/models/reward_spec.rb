require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'Associations' do
    it { should belong_to(:user).optional(true) }
    it { should belong_to :question }

    it 'should have one attached image' do
      expect(Reward.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
