# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :workspace_code, presence: true, uniqueness: true
  validates :access_token, presence: true
  enum open_ai_model: %i[gpt-4-turbo gpt-4o]
end
