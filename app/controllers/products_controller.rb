class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def add_to_cart
    product = Product.find(params[:id])
    cart_item = current_cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += 1 # Increment the quantity by 1
    cart_item.save

    redirect_to dashboard_index_path, notice: "#{product.name} has been added to your cart."
  end
end
