# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer for question' do
  given!(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to answer for question' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'Some answer'
    click_on 'Submit answer'

    expect(page).to have_content 'Answer was created!'
    expect(page).to have_content 'Some answer'
  end

  scenario 'Unauthenticated user tries to answer for question' do
    visit question_path(question)
    fill_in 'Body', with: 'Some answer'
    click_on 'Submit answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
