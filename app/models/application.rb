class Application < ApplicationRecord
  validates :app_name, presence: true
  validates :token, presence: true

  before_create
  def set_chat_counts
    self.chat_count=0
  end
end
