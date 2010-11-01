class RecipesController < ApplicationController

  before_filter :set_category_id, :only => [:update, :create]

  before_filter :load_user
  load_and_authorize_resource :find_by => :slug,
    :through => [:user, :current_user], :collection => [:search]

  respond_to :html, :js

  def index
    @recipes = @recipes.order(:name).
        paginate(:page => params[:page], :per_page => 10)

    respond_with @recipes
  end

  def search
    if params[:friends] == '1'
      ids = [current_user.id] + current_user.friends.map(&:id)
      @recipes = Recipe.where(:user_id => ids)
    end

    if params[:q].present?
      @recipes = @recipes.search params[:q]
    end

    # PostgreSQL doesn't like this without :total_entries because apparently
    # calling :count on the collection then throws an invalid SQL exception.
    # The count is called by will_paginate, and who knows why it's broken, but
    # this seems to work for now...
    @recipes = @recipes.order('recipes.name').
        paginate(:page => params[:page], :per_page => 10,
                 :total_entries => @recipes.group('recipes.id').count.size)

    respond_with @recipes do |format|
      format.html { render :action => 'index' }
    end
  end

  def box
    respond_to do |format|
      format.html
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

    respond_with @recipe do |format|
      format.js { redirect_to :action => 'index' }
    end
  end

  def category_search
    @categories = Category.search(params[:q]).limit(params[:limit]).
      select('DISTINCT(name)')

    render :text => @categories.map(&:name).join("\n")
  end

  def ingredient_search
    @ingredients = Ingredient.search(params[:q]).limit(params[:limit]).
      select('DISTINCT(name)')

    render :text => @ingredients.map(&:name).join("\n")
  end

  protected

  def set_category_id
    name = params[:recipe][:category_attributes][:name]
    category = Category.find_by_name(name)

    if category
      params[:recipe].delete(:category_attributes)
      params[:recipe][:category_id] = category.id
    end
  end
end
