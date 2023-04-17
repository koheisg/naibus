# frozen_string_literal: true

json.array! @chat_threads, partial: 'chat_threads/chat_thread', as: :chat_thread
