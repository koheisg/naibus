json.extract! chat_thread, :id, :message_code, :ts_code, :message, :role, :team_code, :channel_code, :created_at, :updated_at
json.url chat_thread_url(chat_thread, format: :json)
