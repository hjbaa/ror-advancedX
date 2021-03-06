# frozen_string_literal: true

require 'rails_helper'

feature 'User can create question' do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Your question', with: 'Question title'
      fill_in 'Description', with: 'text text text'
      click_on 'Submit'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Question title'
      expect(page).to have_content 'text text text'
    end

    scenario 'asks a question with errors' do
      click_on 'Submit'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with attachments' do
      fill_in 'Your question', with: 'Question title'
      fill_in 'Description', with: 'text text text'
      attach_file 'Add files', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]

      click_on 'Submit'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'asks question with reward', js: true do
      fill_in 'Your question', with: 'Question title'
      fill_in 'Description', with: 'text text text'
      fill_in "Reward's name", with: 'You are very cool guy!'
      attach_file 'Add image for reward', "#{Rails.root}/app/assets/images/qwerty.png"

      click_on 'Submit'

      expect(page).to have_content 'You are very cool guy!'
      expect(page.find('#reward-image')['src']).to have_content 'qwerty.png'
      expect(page.find('#reward-image')['alt']).to match('You are very cool guy! image')
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
