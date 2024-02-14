# == Schema Information
#
# Table name: chat_messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  data       :jsonb
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :bigint           not null
#
# Indexes
#
#  index_chat_messages_on_chat_id  (chat_id)
#  index_chat_messages_on_role     (role)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#
class Chat::Message < ApplicationRecord
  belongs_to :chat
end
