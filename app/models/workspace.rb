# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :workspace_code, presence: true, uniqueness: true
  validates :access_token, presence: true
  enum open_ai_model: ['gpt-4.1-nano']
end
