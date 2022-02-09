require 'rails_helper'

feature 'User can see detailed information about question' do
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'User sees questions body and answers for this question' do
    visit root_path
    click_on 'Show'

    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end
end
