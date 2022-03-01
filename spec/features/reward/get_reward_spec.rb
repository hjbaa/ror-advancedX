# frozen_string_literal: true

require 'rails_helper'

feature 'User can get reward for his answer for question', js: true do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:reward) { create(:reward, question: question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'User gained his rewards' do
    sign_in user
    visit question_path(question)

    within '.answers' do
      click_on 'Best'
    end

    visit rewards_path

    expect(page).to have_content question.title
    expect(page).to have_content reward.name
    expect(page.find('#reward-image')['alt']).to match("#{reward.name} image")
  end
end
