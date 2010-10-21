class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']

    user = User.find_by_fb_uid(omniauth['uid'])

    if user.nil?
      user = User.new
      user.apply_omniauth(omniauth)
    end

    user.access_token = omniauth['credentials']['token']
    user.timezone     = omniauth['extra']['user_hash']['timezone']
    user.fb_username  = omniauth['user_info']['nickname']
    user.save!

    flash[:notice] = 'Signed in successfully.'
    sign_in_and_redirect user
  end

end
