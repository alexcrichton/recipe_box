class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exn|
    redirect_to '/auth/facebook'
  end

  helper :layout
end
