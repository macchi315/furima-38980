class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new]

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

  private

  def item_params
    params.require(:item).permit(:price, :item_name, :item_explanation, :category_id, :description_id, :charge_id, :prefecture_id,
                                 :day_id, :image).merge(user_id: current_user.id)
  end
end

def move_to_login
  return if user_signed_in?

  redirect_to(new_user_session_path)
end
