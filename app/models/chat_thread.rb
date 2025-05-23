# frozen_string_literal: true

class ChatThread < ApplicationRecord
  has_many :ref_urls

  enum role: { user: 0, assistant: 1 }
end
