require 'rails_helper'

feature 'User can add links to answer', js: true do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:gist_url) { 'https://gist.github.com/hjbaa/d95569f97548d91d00219db59862a463' }
  given(:google_url) { 'https://google.com' }
  given(:gist_content) { 'hello world, it is a gist content' }

  scenario 'User adds gist link when asks question' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'Answer title'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Submit answer'
    page.refresh

    within '.answers' do
      expect(page).to have_content gist_content
    end
  end

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'Answer title'

    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: google_url

    click_on 'Submit answer'

    within '.answers' do
      expect(page).to have_link 'Google', href: google_url
    end
  end
end
