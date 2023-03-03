class AddWorkspaceToOpenAiAccessToken < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :open_ai_access_token, :string
  end
end
