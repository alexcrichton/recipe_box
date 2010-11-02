class Ingredient
  include Mongoid::Document

  field :quantity
  field :name

  embedded_in :recipe, :inverse_of => :ingredients

  validates_presence_of :name
  after_save :parse_quantity
end
