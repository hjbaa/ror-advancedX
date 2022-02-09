# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    association :question
    association :author, factory: :user

    body { 'MyStringForAnswer' }

    trait :invalid do
      body { nil }
    end
  end
end
