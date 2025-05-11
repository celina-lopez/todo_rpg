class RoomsController < ApplicationController
  before_action :set_user, :set_room

  def index
  end

  def update
    if params[:hush_key] == @user.hush_key
      @room.update(character: params[:character])
    end
    redirect_to user_room_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_room
    @room = @user.room
  end
end
