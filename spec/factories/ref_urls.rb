FactoryBot.define do
  factory :ref_url do
    chat_thread { nil }
    url { "MyString" }
    title { "MyText" }
    body { "MyText" }
  end
end
