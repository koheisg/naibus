# frozen_string_literal: true

class CreateWorkspaces < ActiveRecord::Migration[7.0]
  def change
    create_table :workspaces do |t|
      t.string :workspace_code
      t.string :access_token

      t.timestamps
    end
    add_index :workspaces, :workspace_code
  end
end
