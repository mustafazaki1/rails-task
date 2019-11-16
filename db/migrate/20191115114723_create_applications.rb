class CreateApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :app_name, null:false
      t.integer :chat_count , default: 0
      t.timestamps
    end
  end
end
