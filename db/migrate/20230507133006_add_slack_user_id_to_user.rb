class AddSlackUserIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slack_user_id, :string
  end
end
