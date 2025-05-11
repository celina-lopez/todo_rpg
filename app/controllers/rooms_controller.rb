class RoomsController < ApplicationController
  before_action :set_user

  def index
    @room = @user.room
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
