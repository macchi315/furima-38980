class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new, :edit]
  before_action :move_to_index, only: [:edit, :update]
  before_action :move_item, only: [:show, :edit, :update]

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

def move_to_index
  @item = Item.find(params[:id])
  return if user_signed_in? && current_user.id == @item.user_id

  redirect_to action: :index
end

def move_item
  @item = Item.find(params[:id])
end