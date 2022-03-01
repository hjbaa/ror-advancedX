# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    name { 'MyReward' }
    image { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/qwerty.png") }
  end
end
