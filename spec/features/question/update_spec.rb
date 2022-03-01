# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his question' do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given(:google_url) { 'https://google.com' }

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

    scenario 'edits his question, attaching files' do
      sign_in user
      visit question_path(question)
      click_on 'Edit question'

      within('.question') do
        attach_file 'Add files', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]

        click_on 'Save'

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario 'edits his answer, adding links' do
      sign_in user
      visit question_path(question)
      click_on 'Edit question'

      within('.question') do
        click_on 'Add one more link'
        fill_in 'Link name', with: 'Google'
        fill_in 'Url', with: google_url
        click_on 'Save'

        expect(page).to have_link 'Google', href: google_url
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
