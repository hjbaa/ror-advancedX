# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy his own answers' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }

  scenario 'Author destroys his question' do
    sign_in(author)

    visit root_path
    expect(page).to have_content question.title

    click_on 'Show'
    expect(page).to have_content question.body

    click_on 'Destroy question'

    expect(page).not_to have_content question.title
    expect(page).to have_content 'Your question successfully destroyed.'
  end

  scenario 'Unauthenticated user wants to destroy question' do
    visit question_path(question)
    expect(page).not_to have_button 'Destroy question'
  end

  scenario 'Not-author wants to destroy question' do
    sign_in(user)
    visit question_path(question)
    expect(page).not_to have_button 'Destroy question'
  end
end
