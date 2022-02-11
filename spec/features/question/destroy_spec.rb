# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy his own answers' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }

  scenario 'Author destroys his question' do
    sign_in(author)
    visit question_path(question)
    click_on 'Destroy question'

    expect(page).to have_content 'Your question successfully destroyed.'
  end

  scenario 'Unauthenticated user wants to destroy question' do
    visit question_path(question)
    expect(page.has_button?('Destroy question')).to be_falsey
  end

  scenario 'Not-author wants to destroy question' do
    sign_in(user)
    visit question_path(question)
    expect(page.has_button?('Destroy question')).to be_falsey
  end
end
