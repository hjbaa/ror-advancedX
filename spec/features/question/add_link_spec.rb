require 'rails_helper'

feature 'User can add links to question', js: true do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/hjbaa/d95569f97548d91d00219db59862a463' }
  given(:google_url) { 'https://google.com' }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds link when asks question' do
    fill_in 'Your question', with: 'Question title'
    fill_in 'Description', with: 'text text text'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Submit'

    expect(page).to have_link 'My gist', href: gist_url
  end
end
