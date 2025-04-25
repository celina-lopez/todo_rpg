class CategoriesController < ApplicationController
  before_action :set_user
  before_action :set_category, only: [ :update, :destroy ]

  def create
    @category = @user.categories.create(category_params)
    render json: @category.to_json
  end

  def update
    @category.update(category_params)
    render json: @category.to_json
  end

  def destroy
    @category.destroy
    render json: { success: true }
  end
  private

  def set_user
    @user = User.find_by(hush_key: params[:hush_key])
    redirect_to root_path, alert: "You aren't allowed in here!!!" if @user.blank?
  end

  def set_category
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
