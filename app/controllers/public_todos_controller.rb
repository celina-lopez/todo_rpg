class PublicTodosController < ApplicationController
  layout "todo"

  def show
    @user = User.find_by!(uid: params[:uid])
    @categories = @user.categories.where(is_public: true).includes(:items)
  end
end
