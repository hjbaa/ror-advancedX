# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete the files attached to the question', js: true do
  given(:user) { create(:user) }

  background do
    sign_in user
    visit questions_path
    click_on 'Ask question'
    fill_in 'Your question', with: 'Question title'
    fill_in 'Description', with: 'text text text'
    attach_file 'Add files', "#{Rails.root}/spec/rails_helper.rb"

    click_on 'Submit'
  end

  scenario 'User destroys his attachments' do
    click_on 'Delete this file'
    page.accept_confirm
    expect(page).to_not have_link 'rails_helper.rb'
  end
end
