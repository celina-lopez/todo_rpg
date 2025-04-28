class Categories::ItemsController < ApplicationController
  before_action :set_user
  before_action :set_category
  before_action :set_item, only: [ :update, :destroy ]

  def create
    @item = @category.items.create(item_params)
    respond_to do |format|
      format.json { render json: @item }
    end
  end

  def update
    @item.update(item_params)
    respond_to do |format|
      format.json { render json: @item }
    end
  end

  def destroy
    @item.destroy
  end

  private

  def set_user
    @user = User.find_by(hush_key: params[:hush_key])
    redirect_to root_path, alert: "You aren't allowed in here!!!" if @user.blank?
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_item
    @item = @category.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :completed, :repeating)
  end
end
