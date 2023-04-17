# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :workspace_code, presence: true, uniqueness: true
  validates :access_token, presence: true
end
