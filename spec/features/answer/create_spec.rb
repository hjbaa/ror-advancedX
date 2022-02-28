# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer for question' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'tries to create correct answer for question' do
      fill_in 'Your answer', with: 'Some answer'
      click_on 'Submit answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'Some answer'
      end
    end

    scenario 'tries to create incorrect answer for question' do
      click_on 'Submit answer'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'tries to create answer with attachments' do
      within '.new-answer' do
        fill_in 'Your answer', with: 'Some answer'
        attach_file 'Add files', %W[#{Rails.root}/spec/rails_helper.rb #{Rails.root}/spec/spec_helper.rb]
        click_on 'Submit answer'
      end

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  scenario 'Unauthenticated user tries to answer for question' do
    visit question_path(question)
    fill_in 'Your answer', with: 'Some answer'
    click_on 'Submit answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
