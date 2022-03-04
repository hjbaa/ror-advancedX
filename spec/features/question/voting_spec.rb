require 'rails_helper'

feature 'User can vote for question', 'To determine the usefulness of the question,
    I, as a user, want to see the rating of the question', js: true do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: second_user) }

  describe 'Authenticated user' do
    scenario 'sees rating of question' do
      sign_in user
      visit question_path(question)

      within '.question .voting' do
        expect(page).to have_content('Total rating: 0')
      end
    end

    describe '(none-author of question)' do
      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'votes up for the question' do
        within '.question .voting' do
          click_on 'Upvote'
          expect(page).to have_content('Total rating: 1')
        end
      end

      scenario 'votes down for the question' do
        within '.question .voting' do
          click_on 'Downvote'
          expect(page).to have_content('Total rating: -1')
        end
      end

      scenario 'tries to vote for second time for the question' do
        within '.question .voting' do
          click_on 'Upvote'
          expect(page).to_not have_button('Upvote')
          expect(page).to_not have_button('Downvote')
        end
      end
    end

    describe '(author of question)' do
      scenario 'tries to vote for the question' do
        sign_in second_user
        visit question_path(question)

        within '.question .voting' do
          expect(page).to_not have_button('Upvote')
          expect(page).to_not have_button('Downvote')
        end
      end
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit question_path(question)
    end

    scenario 'sees rating of question' do
      within '.question .voting' do
        expect(page).to have_content('Total rating: 0')
      end
    end

    scenario 'tries to vote for question' do
      within '.question .voting' do
        expect(page).to_not have_button('Upvote')
        expect(page).to_not have_button('Downvote')
      end
    end
  end
end

