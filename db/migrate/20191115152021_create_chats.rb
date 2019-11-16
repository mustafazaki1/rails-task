class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.integer :chat_number
      t.integer :message_count
      t.references :applications, foreign_key:true
      t.timestamps
    end
  end
end
