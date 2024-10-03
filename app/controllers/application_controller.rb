class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_cart

  # Redirect to dashboard after login
  def after_sign_in_path_for(resource)
  	if resource.is_admin?
  		admin_root_path
  	else
  		dashboard_index_path
  	end
  end

  def current_cart
    current_user.cart || current_user.create_cart!
  end
end
