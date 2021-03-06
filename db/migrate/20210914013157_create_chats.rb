class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :chat_room_id, null: false
      t.integer :user_id, null: false
      t.text :response, null: false

      t.timestamps
    end
  end
end
