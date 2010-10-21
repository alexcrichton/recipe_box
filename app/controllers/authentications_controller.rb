class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']

    user = User.find_or_create_by_fb_uid(omniauth['uid'])
    user.apply_omniauth(omniauth)
    user.save!

    flash[:notice] = 'Signed in successfully.'
    sign_in_and_redirect user
  end

end
