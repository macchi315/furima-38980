class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new, :edit, :destroy]
  before_action :move_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:price, :item_name, :item_explanation, :category_id, :description_id, :charge_id, :prefecture_id,
                                 :day_id, :image).merge(user_id: current_user.id)
  end

  def move_to_login
    return if user_signed_in?

    redirect_to(new_user_session_path)
  end

  def move_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return unless current_user.id == @item.user_id && !@item.order.nil?

    redirect_to items_path
  end
end
