require 'rails_helper'

feature 'User can see the list of all question' do
  given!(:first_question) { create(:question) }
  given!(:second_question) { create(:question) }

  scenario 'User sees all questions' do
    visit root_path
    expect(page).to have_content first_question.title
    expect(page).to have_content second_question.title
  end
end
