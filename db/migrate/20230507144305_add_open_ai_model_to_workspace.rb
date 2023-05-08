class AddOpenAiModelToWorkspace < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :open_ai_model, :integer, default: 0
  end
end
