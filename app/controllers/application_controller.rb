class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	def after_sign_in_path_for(user)
    request.env['omniauth.origin'] || stored_location_for(user) || contacts_path
  end
#skip_before_filter :verify_authenticity_token
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
