class ChatThread < ApplicationRecord
  enum role: { user: 0, assistant: 1, system: 2 }
end
