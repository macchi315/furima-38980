class ItemsController < ApplicationController

  def index
  end

  def new
    #@item = item.new
  end

  def create
    @item = item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    item.require(:item).permit(:item_name,:item_explanation,:category_id,:description_id,:charge_id,:prefecture_id,:day_id, :image)
  end

end