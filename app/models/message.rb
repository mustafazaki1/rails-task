class Message < ApplicationRecord
  validates :message_number, presence: true
  validates :body, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  settings do
    mappings dynamic: false do
      indexes :body, type: :text
      indexes :message_number
      indexes :chats_id
    end
  end

  def self.search_published(query,chat_id)
    self.search({
                    "query": {
                        "bool": {
                            "must": [
                                {
                                    "match": {
                                        "body": {
                                            "query": '.*'+query+'.*',
                                            "operator": "and"
                                        }
                                    }
                                },
                                {
                                    "match": {
                                        "chats_id": {
                                            "query": chat_id,
                                            "operator": "and"
                                        }
                                    }
                                }
                            ]
                        }
                    }
                })
  end
end
