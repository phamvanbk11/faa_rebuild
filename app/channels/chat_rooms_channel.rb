class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
  end

  def send_message data
    Message.create!(message: data["message"], chat_room_id: data["chat_room_id"])
  end
end
