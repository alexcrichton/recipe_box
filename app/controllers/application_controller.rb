class ApplicationController < ActionController::Base
  protect_from_forgery
  layout Proc.new{ |c| c.request.xhr? ? false : 'application' }
  
  helper_method :current_user
  helper :layout
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = session[:fb_uid].blank? ? nil :
        User.find_by_fb_uid(session[:fb_uid])
  end
  
  def current_user= user
    session[:fb_uid] = user.try :fb_uid
  end
end