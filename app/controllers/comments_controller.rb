class CommentsController < ApplicationController

  respond_to :js

  load_resource :recipe, :find_by => :slug
  load_and_authorize_resource :through => :recipe

  def index
    respond_with @comments
  end

  def new
    respond_with @comment
  end

  def create
    @comment.user = current_user
    @comment.save

    respond_with @comment
  end

end
