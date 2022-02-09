class AddColumnAuthorToQuestionAndAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :author_id, :integer
    add_foreign_key :questions, :users, column: :author_id, to_table: :users
    add_index :questions, :author_id
    add_column :answers, :author_id, :integer
    add_foreign_key :answers, :users, column: :author_id, to_table: :users
    add_index :answers, :author_id
  end
end
