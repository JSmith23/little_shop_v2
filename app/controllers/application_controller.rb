class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_cart
  skip_before_action :verify_authenticity_token

  def load_cart
    @cart ||= Cart.new(session[:cart])
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def registered_user?
    current_user && current_user.registered_user?
  end

  def merchant_user?
    current_user && current_user.merchant?
  end

  def admin_user?
    current_user && current_user.admin?
  end

  def request_path
    # removes all numbers and slashes from path_info
    # e.g., '/users/5/orders' returns 'usersorders'
    request.env["PATH_INFO"].tr("0-9", "").tr("/", "")
  end

  def show_unauthorized_error_and_redirect
    flash[:error] = "You are not authorized to view the requested page."
    redirect_to root_path
  end

  helper_method :current_user, :admin_user?, :registered_user?, :merchant_user?, :request_path

end
