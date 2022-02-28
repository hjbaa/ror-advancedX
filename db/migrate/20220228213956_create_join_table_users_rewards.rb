class CreateJoinTableUsersRewards < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rewards, :users do |t|
      t.index [:reward_id, :user_id]
      # t.index [:user_id, :reward_id]
    end
  end
end
