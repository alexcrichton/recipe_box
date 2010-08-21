class AddRecipeSlugAndIndexes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :slug, :string
    
    add_index :recipes, :slug, :unique => true
    
    add_index :ingredients, :recipe_id
    add_index :recipes, :category_id
    add_index :recipes, :name
    add_index :ingredients, :name
    add_index :categories, :name
  end

  def self.down
    remove_column :recipes, :slug
  end
end
