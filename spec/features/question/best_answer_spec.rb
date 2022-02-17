# frozen_string_literal: true

require 'rails_helper'

feature 'User can mark answer as best', js: true do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  describe 'Authenticated user' do
    scenario 'tries to mark answer as best for his question' do
      sign_in user
      visit question_path(question)

      within '.all_answers' do
        click_on 'Best'
        expect(page).to_not have_content answer.body
      end

      within '.best_answer' do
        expect(page).to have_content answer.body
        expect(page).to have_link 'Unmark'
      end
    end

    scenario 'tries to mark another answer as best for his question' do
      sign_in user
      visit question_path(question)
      click_on 'Best'
      second_answer = create(:answer, question: question, author: user)
      visit question_path(question)

      within '.all_answers' do
        click_on 'Best'
        expect(page).to have_content answer.body
      end

      within '.best_answer' do
        expect(page).to have_content second_answer.body
      end
    end

    scenario 'tries to unmark answer as best' do
      sign_in user
      visit question_path(question)

      within '.answers' do
        click_on 'Best'

        within '.best_answer' do
          click_on 'Unmark'
          expect(page).to_not have_content answer.body
        end

        within '.all_answers' do
          expect(page).to have_content answer.body
        end
      end
    end

    scenario "tries to mark answer as best for another user's question" do
      sign_in second_user
      visit question_path(question)
      expect(page).to_not have_button 'Best'
    end
  end

  scenario 'Unauthenticated user tries to mark answer as best' do
    visit question_path(question)
    expect(page).to_not have_button 'Best'
  end
end
