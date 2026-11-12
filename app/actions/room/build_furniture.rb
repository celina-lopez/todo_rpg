# frozen_string_literal: true

class Room::BuildFurniture
  extend LightService::Action
  LEVELS_DATA = YAML.load_file(Rails.root.join("lib/assets/levels.json"))

  expects :room

  # levels.json stops at 10; higher room levels keep the furniture of the last defined level
  def self.data_for(level)
    LEVELS_DATA[[ level, LEVELS_DATA.keys.map(&:to_i).max ].min.to_s] || []
  end

  # Rebuilds the room's furniture for its current level. Pieces the player has
  # already placed keep their position; new pieces use the level's default spot.
  executed do |context|
    room = context.room
    furniture_data = data_for(room.level)
    existing = room.furnitures.to_a

    room.transaction do
      kept_ids = furniture_data.map do |type, x, y|
        match = existing.find { |f| f.furniture_type == type }
        if match
          existing.delete(match)
          match.id
        else
          room.furnitures.create!(furniture_type: type, coordinate_x: x, coordinate_y: y).id
        end
      end
      room.furnitures.where.not(id: kept_ids).destroy_all
      room.update_columns(furniture_level: room.level)
    end
  end
end
