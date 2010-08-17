class Recipe < ActiveRecord::Base
  has_many :ingredients
  belongs_to :category
  
  validates_presence_of :name, :directions
  validates_uniqueness_of :name
end
