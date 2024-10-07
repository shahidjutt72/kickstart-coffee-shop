class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def new
    @order = current_user.orders.new(status: 'pending')
    set_order_items
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = 'ready'
    set_order_items

    if @order.save!
      @cart.clear_cart
      UserMailer.with(order: @order).order_ready.deliver
      redirect_to orders_path, notice: 'Order successfully placed! You will be notified as well.'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :total, :total_tax, :total_discount, :status, :address, :payment_method)
  end

  def set_cart
    @cart = current_cart
  end

  def set_order_items
    @order.assign_cart_items(@cart)
    Orders::Calculator.new(@order).calculate
  end
end
