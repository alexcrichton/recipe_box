class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']

    user = User.where(:fb_uid => omniauth['uid']).first
    user ||= User.new :fb_uid => omniauth['uid']
    user.apply_omniauth(omniauth)
    user.save!

    flash[:notice] = 'Signed in successfully.'
    sign_in_and_redirect user
  end

end
