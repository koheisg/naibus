FactoryBot.define do
  factory :workspace do
    sequence(:workspace_code) { |n| "workspace_code_#{n}" }
    sequence(:access_token) { |n| "access token #{n}" }
  end
end
