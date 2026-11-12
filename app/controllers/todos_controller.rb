class TodosController < ApplicationController
  before_action :set_user
  layout "todo"

  def index
    @furniture_notice = @user.room.furniture_notice
  end

  def dismiss_notice
    @user.room.dismiss_furniture_notice!
    if params[:from] == "room"
      redirect_to user_room_path(@user, hush_key: @user.hush_key)
    else
      redirect_to todos_path(hush_key: @user.hush_key)
    end
  end
end
