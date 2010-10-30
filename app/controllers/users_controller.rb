class UsersController < ApplicationController
  respond_to :js

  def friends
    respond_with current_user
  end
end
