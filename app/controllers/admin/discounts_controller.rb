class Admin::DiscountsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @discounts = Discount.includes(discount_group: :products).all
  end
  
  def new
    @discount = Discount.new
    @discount.build_discount_group
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      redirect_to admin_discounts_path, notice: 'Discount created successfully with groups and products.'
    else
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      redirect_to admin_discounts_path, notice: 'Discount updated successfully.'
    else
      render :edit
    end
  end

  private

  def discount_params
    params.require(:discount).permit(
      :rate, 
      :discount_type, 
      discount_group_attributes: [
        :id, :_destroy, product_ids: []
      ]
    )
  end

  def require_admin
    redirect_to root_path unless current_user.is_admin?
  end
end
