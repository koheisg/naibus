class AddTeamCodeAndChannelCodeToChatThread < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_threads, :team_code, :string
    add_column :chat_threads, :channel_code, :string
  end
end
