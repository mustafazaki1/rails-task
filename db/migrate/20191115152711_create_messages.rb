class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :message_number
      t.string :body
      t.references :chats, foreign_key:true
      t.timestamps
    end
  end
end
