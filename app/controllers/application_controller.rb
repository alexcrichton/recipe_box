class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user_time_zone

  rescue_from CanCan::AccessDenied do |exn|
    redirect_to '/auth/facebook'
  end

  helper :layout

  protected

  def set_user_time_zone
    if current_user && current_user.timezone
      Time.zone = ActiveSupport::TimeZone[current_user.timezone]
    end
  end
end
