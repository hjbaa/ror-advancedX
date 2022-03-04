# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Associations' do
    it { should belong_to(:question) }
    it { should belong_to(:author) }

    it { should have_many(:links).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }

    it 'should have many attached files' do
      expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe 'Validations' do
    it { should validate_presence_of :body }
  end
end
