class RoomsController < ApplicationController
  CHARACTER_SPRITE = YAML.load_file(Rails.root.join("lib/assets/characters.json"))
  FURNITURE = YAML.load_file(Rails.root.join("lib/assets/furniture.json"))
  before_action :set_user, :set_room
  layout "game"

  def index
    decrement_by = (Date.today - @room.updated_at.to_date).to_i
    @room.decrement_level!(decrement_by)
    # TODO: add back in
    # Room::BuildFurniture.execute(room: @room)
    @character_sprite = CHARACTER_SPRITE[@room.character]
    @furniture = YAML.load_file(Rails.root.join("lib/assets/furniture.json"))
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
