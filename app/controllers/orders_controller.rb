class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_item_index, only: [:index]
  before_action :sold_out_index, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_payment = OrderPayment.new
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      pay_item
      @order_payment.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def move_to_item_index
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
    redirect_to items_path
    end
  end

  def sold_out_index
    if @item.order != nil || current_user.id == @item.user_id
      redirect_to items_path
    end
  end

  def order_params
    params.require(:order_payment).permit(:item_id, :postcode, :prefecture_id, :sityouson, :banchi, :build_name, :tell_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],    
      currency: 'jpy'                
    )
  end
end
