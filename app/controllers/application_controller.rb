class ApplicationController < ActionController::Base
#  before_filter :authenticate_user!
  protect_from_forgery

  def after_sign_in_path_for(resource)
  	if (current_user)
		dashboard_user_path(current_user)
  	elsif (current_customer)
 #     raise current_customer.inspect
  		customer_customer_path(current_customer)
  	else

    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if current_customer
      new_customer_session_path
    elsif current_user
      new_user_session_path
    end
  end
end
