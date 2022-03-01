# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to question', js: true do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/hjbaa/d95569f97548d91d00219db59862a463' }
  given(:google_url) { 'https://google.com' }
  given(:gist_content) { 'hello world, it is a gist content' }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds link when asks question' do
    fill_in 'Your question', with: 'Question title'
    fill_in 'Description', with: 'text text text'
    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: google_url

    click_on 'Submit'

    expect(page).to have_link 'Google', href: google_url
  end

  scenario 'User adds link when asks question' do
    fill_in 'Your question', with: 'Question title'
    fill_in 'Description', with: 'text text text'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Submit'

    expect(page).to have_content gist_content
  end
end
