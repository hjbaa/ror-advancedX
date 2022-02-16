# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer for question' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'tries to create correct answer for question' do
      sign_in(user)
      visit question_path(question)
      fill_in 'Your answer', with: 'Some answer'
      click_on 'Submit answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'Some answer'
      end
    end

    scenario 'tries to create incorrect answer for question' do
      sign_in(user)
      visit question_path(question)
      click_on 'Submit answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer for question' do
    visit question_path(question)
    fill_in 'Your answer', with: 'Some answer'
    click_on 'Submit answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
