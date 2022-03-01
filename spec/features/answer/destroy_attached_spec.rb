# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete the files attached to the answer', js: true do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  background do
    sign_in user
    visit question_path(question)
    within '.new-answer' do
      fill_in 'Your answer', with: 'Some answer'
      attach_file 'Add files', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Submit answer'
    end
  end

  scenario 'destroys his attachments' do
    within '.answers' do
      click_on 'Delete this file'
    end

    page.accept_confirm

    expect(page).to_not have_link 'rails_helper.rb'
  end
end
