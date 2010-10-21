class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']

    user = User.find_by_fb_uid(omniauth['uid'])

    if user.nil?
      user = User.new
      user.apply_omniauth(omniauth)
      user.save!
    end

    flash[:notice] = 'Signed in successfully.'
    sign_in_and_redirect user
  end

end
