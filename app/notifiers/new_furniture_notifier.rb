# To deliver this notification:
#
# NewFurnitureNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewFurnitureNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.channel = "Noticed::NotificationChannel"
    config.stream = -> { recipient }
    config.message = -> { params.merge(user_id: recipient.id) }
  end

  notification_methods do
    # I18n helpers
    def message
      "New furniture added: #{params[:furniture_type]}"
    end
  end
end
