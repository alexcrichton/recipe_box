class AddParsedQuantity < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :parsed_quantity, :string
  end

  def self.down
    remove_column :ingredients, :parsed_quantity
  end
end
