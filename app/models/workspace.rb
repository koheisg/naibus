# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :workspace_code, presence: true, uniqueness: true
  validates :access_token, presence: true
  enum open_ai_model: %i[gpt-3.5-turbo gpt-4 gpt-4-1106-preview	code-davinci-002	text-davinci-003]
end
