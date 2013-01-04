class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
    #stored_location_for(resource) || 
  	user_path(resource)
  end
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
