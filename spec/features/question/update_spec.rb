# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his question' do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'edits his question' do
      sign_in user
      visit question_path(question)
      click_on 'Edit question'

      within('.question') do
        fill_in 'Your question', with: 'Some question'
        fill_in 'Description', with: 'Some description'
        click_on 'Save'

        expect(page).to have_content 'Some question'
        expect(page).to have_content 'Some description'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his question with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit question'

      within('.question') do
        fill_in 'Your question', with: ''
        fill_in 'Description', with: ''
        click_on 'Save'

        expect(page).to have_content "Body can't be blank"
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content question.title
        expect(page).to have_content question.body
        expect(page).to have_selector 'textarea'
      end
    end

    scenario "tries to edit another user's question" do
      sign_in second_user
      visit question_path(question)
      expect(page).to_not have_button 'Edit question'
    end
  end

  scenario 'Unauthenticated user can not edit question' do
    visit question_path(question)
    expect(page).to_not have_button 'Edit question'
  end
end