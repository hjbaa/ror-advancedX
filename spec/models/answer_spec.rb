# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Associations' do
    it { should belong_to(:question) }
  end

  describe 'Validations' do
    it { should validate_presence_of :body }
  end
end
