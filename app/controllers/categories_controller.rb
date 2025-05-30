class CategoriesController < ApplicationController
  before_action :set_user
  before_action :set_category, only: [ :update, :destroy ]

  def create
    @category = @user.categories.create(category_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "categories",
          partial: "todos/categories",
          locals: { user: @user }
        )
      end
      format.html { redirect_to todos_path }
      format.json { render json: @category }
    end
  end

  def update
    @category.update(category_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "categories",
          partial: "todos/categories",
          locals: { user: @user }
        )
      end
      format.html { redirect_to todos_path }
      format.json { render json: @category }
    end
  end

  def destroy
    @category.destroy
    render json: { success: true }
  end

  private

  def set_category
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :color)
  end
end
