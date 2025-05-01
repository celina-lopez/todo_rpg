class ItemsController < ApplicationController
  before_action :set_user
  before_action :set_category
  before_action :set_item

  def create
    @items = @category.items.create(items_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "categories",
          partial: "todos/categories",
          locals: { user: @user }
        )
      end
      format.html { redirect_to todos_path }
      format.json { render json: @item }
    end
  end

  def update
    @item.update(items_params)
    render json: @item.to_json
  end

  def destroy
    @item.destroy
    render json: { success: true }
  end
  private

  def set_category
    @category = @user.categories.find(params[:category_id])
  end

  def set_item
    @item = @category.items.find(params[:id])
  end

  def items_params
    params.require(:item).permit(:name, :completed, :repeating)
  end
end
