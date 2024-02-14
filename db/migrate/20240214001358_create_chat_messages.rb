class CreateChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_messages do |t|
      t.string :role
      t.references :chat, null: false, foreign_key: true
      t.text :content
      t.jsonb :data

      t.timestamps
    end
    add_index :chat_messages, :role
  end
end
