class TodosController < ApplicationController
  before_action :set_user

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to todos_path(hush_key: @user.hush_key)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
