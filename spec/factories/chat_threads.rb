# frozen_string_literal: true

FactoryBot.define do
  factory :chat_thread do
    sequence(:message_code) { |n| "message_code_#{n}" }
    sequence(:ts_code) { |n| "ts_code_#{n}" }
    message { 'foo bar' }
    role { :user }
    sequence(:team_code) { |n| "team_code_#{n}" }
    sequence(:channel_code) { |n| "channel_code_#{n}" }
  end
end
