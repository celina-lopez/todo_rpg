# frozen_string_literal: true

class Room::BuildFurniture
  extend LightService::Action
  LEVELS_DATA = YAML.load_file(Rails.root.join("lib/assets/levels.json"))

  expects :room

  executed do |context|
    furniture_data = LEVELS_DATA[context.room.level.to_s]
    context.room.furnitures.destroy_all
    furniture_data.each do |furniture|
      context.room.furnitures.create!(furniture_type: furniture[0], coordinate_x: furniture[1], coordinate_y: furniture[2])
    end
  end
end
