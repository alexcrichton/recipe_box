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
    @recipes = @recipes.search(params[:q]).order(:name).
        paginate(:page => params[:page], :per_page => 10)

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

  def load_user
    if params[:user_id]
      @user = User.find_by_fb_username(params[:user_id]) ||
        User.find_by_fb_uid!(params[:user_id])
    end
  end

  def set_category_id
    name = params[:recipe][:category_attributes][:name]
    category = Category.find_by_name(name)

    if category
      params[:recipe].delete(:category_attributes)
      params[:recipe][:category_id] = category.id
    end
  end
end
