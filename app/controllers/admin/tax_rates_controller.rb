class Admin::TaxRatesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @tax_rates = TaxRate.all
  end

  def show
    @tax_rate = TaxRate.find(params[:id])
  end

  def new
    @tax_rate = TaxRate.new
  end

  def create
    @tax_rate = TaxRate.new(tax_rate_params)
    if @tax_rate.save
      redirect_to admin_tax_rates_path, notice: 'Tax rate created successfully.'
    else
      render :new
    end
  end

  def edit
    @tax_rate = TaxRate.find(params[:id])
  end

  def update
    @tax_rate = TaxRate.find(params[:id])
    if @tax_rate.update(tax_rate_params)
      redirect_to admin_tax_rates_path, notice: 'Tax rate updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @tax_rate = TaxRate.find(params[:id])
    @tax_rate.destroy
    redirect_to admin_tax_rates_path, notice: 'Tax rate deleted successfully.'
  end

  private

  def require_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end

  def tax_rate_params
    params.require(:tax_rate).permit(:rate, :tax_type, :product_id)
  end
end
