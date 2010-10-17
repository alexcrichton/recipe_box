class ApplicationController < ActionController::Base
  protect_from_forgery
  layout Proc.new{ |c| c.request.xhr? ? false : 'application' }
  
  helper :layout

  def current_user
    nil
  end
  
end