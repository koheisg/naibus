class AddWorkspaceToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :workspace, null: false, foreign_key: true
  end
end
