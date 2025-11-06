class FurnituresController < ApplicationController
  before_action :set_user
  before_action :set_furniture
  skip_before_action :verify_authenticity_token

  def update
    @furniture.update(furniture_params)
    render json: @furniture
  end

  private

  def set_furniture
    @furniture = @user.room.furnitures.find(params[:id])
  end

  def furniture_params
    params.require(:furniture).permit(:coordinate_x, :coordinate_y)
  end
end
