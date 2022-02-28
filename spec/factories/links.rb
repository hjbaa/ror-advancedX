FactoryBot.define do
  factory :link do
    name { 'MyString' }
    url { 'https://example.com' }

    trait :google do
      name { 'Google' }
      url { 'https://google.com' }
    end
  end
end
