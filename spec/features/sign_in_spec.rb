require 'rails_helper'

feature 'User can sign in', "In order to ask questions as an unauthenticated user I'd like to be able to sign in" do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'test@test.com', password: '12345678')

    visit '/login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistered user tries to sign in'
end
