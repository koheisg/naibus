# frozen_string_literal: true

class CreateChatThreads < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_threads do |t|
      t.string :message_code
      t.string :ts_code
      t.text :message
      t.integer :role

      t.timestamps
    end
    add_index :chat_threads, %i[message_code role], unique: true
  end
end
