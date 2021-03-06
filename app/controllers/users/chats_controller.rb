class Users::ChatsController < ApplicationController

  before_action :authenticate_user!

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    chat = Chat.new(chat_params)
    chat.chat_room_id = @chat_room.id
    chat.user_id = current_user.id
    if chat.save!
      redirect_to chat_room_path(@chat_room)
    else
      render 'chat_rooms/show'
    end
  end

  def destroy
    @chat_room = ChatRoom.find(params[:chat_room_id])
    chat = @chat_room.chats.find(params[:id])
    if chat.user_id != current_user.id
      redirect_to chat_room_path(@chat_room.id)
    else
      chat.destroy
      redirect_to chat_room_path(@chat_room.id)
    end
  end

  def chat_params
    params.require(:chat).permit(:response)
  end

end
