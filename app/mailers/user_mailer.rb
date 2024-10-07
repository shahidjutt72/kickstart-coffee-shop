class UserMailer < ApplicationMailer
  def order_ready
    @order = params[:order]
    @user = @order.user
    @order_items = @order.order_items.includes(:product)
    mail(to: @order.user.email, subject: 'Your order is ready')
  end
end
