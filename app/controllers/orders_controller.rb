class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    unless @order_address.valid?
      Rails.logger.debug "ORDER_ADDRESS ERRORS: #{@order_address.errors.full_messages}"
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      return render :index, status: :unprocessable_entity
    end

    begin
      pay_item
      @order_address.save
      redirect_to root_path
    rescue Payjp::PayjpError => e
      Rails.logger.debug "PAYJP ERROR: #{e.message}"
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      flash.now[:alert] = "決済に失敗しました。もう一度お試しください。"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def move_to_root
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @order_address.token,
      currency: 'jpy'
    )
  end
end