# frozen_string_literal: true

require 'rails_helper'

feature 'User can see detailed information about question' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Authenticated user sees questions body and answers for this question' do
    sign_in(user)
    visit root_path
    click_on 'Show'

    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end

  scenario 'Unauthenticated user sees questions body and answers for this question' do
    visit root_path
    click_on 'Show'

    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end
end
