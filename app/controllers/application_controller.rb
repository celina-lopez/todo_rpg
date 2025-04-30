class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_user
    @user = User.find_by(hush_key: params[:hush_key])
    redirect_to root_path, alert: "You aren't allowed in here!!!" if @user.blank?
  end
end
