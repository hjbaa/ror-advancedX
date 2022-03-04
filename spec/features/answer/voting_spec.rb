require 'rails_helper'

feature 'User can vote for answer', 'To determine the usefulness of the answer,
    I, as a user, want to see the rating of the answer', js: true do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: second_user) }

  describe 'Authenticated user' do
    scenario 'sees rating of answer' do
      sign_in user
      visit question_path(question)

      within '.answers .voting' do
        expect(page).to have_content('Total rating: 0')
      end
    end

    describe '(none-author of answer)' do
      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'votes up for the answer' do
        within '.answers .voting' do
          click_on 'Upvote'
          expect(page).to have_content('Total rating: 1')
        end
      end

      scenario 'votes down for the answer' do
        within '.answers .voting' do
          click_on 'Downvote'
          expect(page).to have_content('Total rating: -1')
        end
      end

      scenario 'tries to vote for second time for the answer' do
        within '.answers .voting' do
          click_on 'Upvote'
          expect(page).to_not have_button('Upvote')
          expect(page).to_not have_button('Downvote')
        end
      end

      scenario 'cancelled his vote for answer' do
        within '.answers .voting' do
          click_on 'Upvote'
          click_on 'Cancel vote'
          expect(page).to have_button('Upvote')
          expect(page).to have_button('Downvote')
        end
      end
    end

    describe '(author of answer)' do
      scenario 'tries to vote for the answer' do
        sign_in second_user
        visit question_path(question)

        within '.answers .voting' do
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

    scenario 'sees rating of answer' do
      within '.answers .voting' do
        expect(page).to have_content('Total rating: 0')
      end
    end

    scenario 'tries to vote for answer' do
      expect(page).to_not have_button('Upvote')
      expect(page).to_not have_button('Downvote')
    end
  end
end
