class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user_time_zone

  rescue_from CanCan::AccessDenied do |exn|
    redirect_to '/auth/facebook'
  end

  helper :layout

  protected

  def load_user
    if params[:user_id]
      @user = (User.where(:fb_username => params[:user_id]).first ||
        User.where(:fb_uid => params[:user_id]).first) or
          raise Mongoid::Errors::DocumentNotFound.new(User,
            :fb_uid => params[:user_id])
    end
  end

  def set_user_time_zone
    if current_user && current_user.timezone
      Time.zone = ActiveSupport::TimeZone[current_user.timezone]
    end
  end
end
