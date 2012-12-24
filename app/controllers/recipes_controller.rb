class RecipesController < ApplicationController

  before_filter :set_category_id, :only => [:update, :create]
  before_filter :load, :only => [:show, :edit, :destroy]

  respond_to :html, :js

  def index
    @recipes = Recipe.order_by(:name.asc).page(params[:page]).per(10)

    respond_with @recipes
  end

  def search
    @recipes = Recipe.scoped

    if params[:q].present?
      @recipes = @recipes.search params[:q]
    end

    @recipes = @recipes.order_by(:name.asc).page(params[:page]).per(10)

    respond_with @recipes do |format|
      format.html { render :action => 'index' }
    end
  end

  def box
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_with @recipe
  end

  def new
    @recipe = Recipe.new params[:recipe]
    respond_with @recipe
  end

  def edit
    respond_with @recipe
  end

  def create
    @recipe = Recipe.new(params[:recipe])
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
    @categories = Category.search(params[:q]).limit(params[:limit].to_i)

    render :text => @categories.map(&:name).join("\n")
  end

  protected

  def load
    @recipe = Recipe.where(:slug => params[:id]).first
  end

  def set_category_id
    name = params[:recipe].delete :category_name
    category = Category.where(:name => name).first

    if category
      params[:recipe][:category] = category
    elsif name.present?
      params[:recipe][:category] = Category.create! :name => name
    end
  end
end
