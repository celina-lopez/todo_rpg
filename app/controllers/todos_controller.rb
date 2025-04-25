class TodosController < ApplicationController
  before_action :set_user

  def index
  end

  private

  def set_user
    @user = User.find_by(hush_key: params[:hush_key])
    redirect_to root_path, alert: "You aren't allowed in here!!!" if @user.blank?
  end
end
