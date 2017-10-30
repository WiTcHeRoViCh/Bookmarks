class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authorized?
  	redirect_to root_path unless current_user
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def per_page
	  per_page = 8	
  end

  def current_page(page)
  	page = 1.to_s if page.to_i == 0 || page.to_i < 0
  	return page
  end

  helper_method :current_user
end
