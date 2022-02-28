# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his answer' do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }
  given(:google_url) { 'https://google.com' }

  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)
    expect(page).not_to have_button 'Edit'
  end

  describe 'Authenticated user', js: true do
    scenario 'edits his answer' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer, adding links' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        click_on 'Add one more link'
        fill_in 'Link name', with: 'Google'
        fill_in 'Url', with: google_url
        click_on 'Save'

        expect(page).to have_link 'Google', href: google_url
      end
    end

    scenario 'edits his answer with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Save'
        expect(page).to have_content "Body can't be blank"
        expect(page).to have_content answer.body
      end
    end

    scenario "tries to edit other user's answer" do
      sign_in second_user
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_selector 'textarea'
        expect(page).to_not have_button 'Edit'
      end
    end
  end
end
