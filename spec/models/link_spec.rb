# frozen_string_literal: true

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
        expect(Link.new(name: 'Some name', url: 'hello', linkable: question)).to_not be_valid
      end

      it 'should be valid link' do
        expect(Link.new(name: 'Some name', url: 'https://google.com', linkable: question)).to be_valid
      end
    end
  end

  describe 'Methods' do
    describe 'gist?' do
      let!(:question) { create(:question) }
      let(:google_url) { 'https://google.com' }
      let(:gist_url) { 'https://gist.github.com/hjbaa/d95569f97548d91d00219db59862a463' }

      it 'should not be a gist' do
        expect(Link.new(name: 'Some name', url: google_url, linkable: question)).to_not be_gist
      end

      it 'should not be a gist' do
        expect(Link.new(name: 'Some name', url: gist_url, linkable: question)).to be_gist
      end
    end
  end
end
