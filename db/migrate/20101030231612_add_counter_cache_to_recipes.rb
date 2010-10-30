class AddCounterCacheToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :comments_count, :integer
  end

  def self.down
    remove_column :recipes, :comments_count
  end
end
