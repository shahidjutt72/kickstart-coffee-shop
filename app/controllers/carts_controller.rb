class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
  end
end
