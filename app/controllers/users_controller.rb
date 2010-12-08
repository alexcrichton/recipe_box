class UsersController < ApplicationController
  respond_to :js, :html

  def friends
    respond_with current_user
  end
end
