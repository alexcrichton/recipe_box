class RecipesController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :js

  def index
    @recipes = Recipe.paginate(:page => params[:page], :per_page => 10)

    respond_with @recipes
  end
  
  def search
    @recipes = Recipe.search params[:q]

    respond_with @recipes do |format|
      format.html { render :action => 'index' }
    end
  end
  
  def box
    respond_to do |format|
      format.html { render :layout => 'box' }
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
