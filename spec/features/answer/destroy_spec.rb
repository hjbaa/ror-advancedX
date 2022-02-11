# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy his own answers' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }

  scenario 'Author destroys his answer' do
    sign_in(author)
    visit question_path(question)
    click_on 'Destroy'

    expect(page).to have_content 'Answer was destroyed!'
  end

  scenario 'Unauthenticated user wants to destroy answer' do
    visit question_path(question)
    expect(page.has_button?('Destroy')).to be_falsey
  end

  scenario 'Not-author wants to destroy answer' do
    sign_in(user)
    visit question_path(question)
    expect(page.has_button?('Destroy')).to be_falsey
  end
end
