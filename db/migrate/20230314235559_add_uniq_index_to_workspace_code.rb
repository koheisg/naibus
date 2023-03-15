class AddUniqIndexToWorkspaceCode < ActiveRecord::Migration[7.0]
  def change
    remove_index :workspaces, name: :index_workspaces_on_workspace_code, if_exists: true
    add_index :workspaces, :workspace_code, unique: true
  end
end
