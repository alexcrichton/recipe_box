class RecipesController < ApplicationController

  load_and_authorize_resource
  respond_to :html

  def index
    respond_with @recipes = Recipe.all
  end
  
  def search
    @recipes = Recipe.search params[:q]

    respond_with @recipes do |format|
      format.html { render :action => 'index' }
    end
  end

  def show
    respond_with @recipe
  end

  def new
    respond_with @recipe
  end

  def edit
    respond_with @recipe
  end

  def create
    @recipe.save

    respond_with @recipe
  end

  def update
    @recipe.update_attributes params[:recipe]

    respond_with @recipe
  end

  def destroy
    @recipe.destroy

    respond_with @recipe
  end

end
