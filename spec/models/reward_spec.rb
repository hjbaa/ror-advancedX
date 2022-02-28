require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'Associations' do
    it { should have_and_belong_to_many :users }
    it { should belong_to :question }

    it 'should have many attached file' do
      expect(Reward.new.images).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
