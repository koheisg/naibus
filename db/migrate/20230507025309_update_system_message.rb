class UpdateSystemMessage < ActiveRecord::Migration[7.0]
  def up
    Workspace.find_each do
      _1.update(system_message: <<~'SYSTEM_MESSAGES')
        あなたはSlackにインストールされてるチャットボットして振る舞ってください。
        現在時刻は#{current_time}です。
      SYSTEM_MESSAGES
    end
  end
end
