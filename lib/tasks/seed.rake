namespace :seed do
  desc "Seed the database with some data"
  task :furniture, [ :user_id ] => [ :environment ] do |t, args|
    room = User.find(args[:user_id]).room
    room.furnitures.create!(furniture_type: :blue_couch_forward, coordinate_x: 31, coordinate_y: 192)
    room.furnitures.create!(furniture_type: :blue_couch_forward, coordinate_x: 31, coordinate_y: 192)
  end
end
