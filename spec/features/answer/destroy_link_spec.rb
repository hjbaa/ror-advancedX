# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy links, attached to his answer', js: true do
  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, author: user, question: question) }
  given!(:link) { create(:link, linkable: answer) }

  describe 'Authenticated user' do
    scenario 'tries to destroy his link' do
      sign_in user
      visit question_path(question)

      within '.answers' do
        click_on 'Destroy this link'
        page.accept_confirm
        expect(page).to_not have_link link.name, href: link.url
      end
    end

    scenario "tries to destroy another user's link" do
      sign_in second_user
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Destroy this link'
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario "tries to destroy another user's link" do
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Destroy this link'
      end
    end
  end
end
