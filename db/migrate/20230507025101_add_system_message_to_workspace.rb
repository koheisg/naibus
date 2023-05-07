class AddSystemMessageToWorkspace < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :system_message, :text
  end
end
