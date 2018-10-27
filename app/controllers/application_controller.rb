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
  
  helper_method :current_user

  def authorize 
    redirect_to login_path, alert: "Not Authorized" if current_user.nil?
  end 

end
