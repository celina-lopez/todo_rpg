namespace :seed do
  desc "Seed the database with some data"
  task :furniture, [ :user_id ] => [ :environment ] do |t, args|
    room = User.find(args[:user_id]).room
    file = File.read("lib/assets/testing_furniture.json")
    data = JSON.parse(file)
    data.each do |item, coordinates|
      room.furnitures.create!(furniture_type: item, coordinate_x: coordinates[0], coordinate_y: coordinates[1])
    end
  end
end
