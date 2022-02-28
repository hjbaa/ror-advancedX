require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'Associations' do
    it { should belong_to :linkable }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :url }

    describe 'URL format' do
      let!(:question) { create(:question) }

      it 'should not be valid link' do
        expect(Link.new(name: 'Some name', url: 'hello', linkable: question).valid?).to be_falsey
      end

      it 'should be valid link' do
        expect(Link.new(name: 'Some name', url: 'https://google.com', linkable: question).valid?).to be_truthy
      end
    end
  end
end
