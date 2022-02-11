# frozen_string_literal: true

class AddColumnAuthorToQuestionAndAnswer < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :questions, :author, foreign_key: { to_table: :users, column: :id }
    add_belongs_to :answers, :author, foreign_key: { to_table: :users, column: :id }
  end
end
