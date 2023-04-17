# frozen_string_literal: true

FactoryBot.define do
  factory :ref_url do
    chat_thread
    url { 'MyString' }
    title { 'MyText' }
    body { 'MyText' }
  end
end
