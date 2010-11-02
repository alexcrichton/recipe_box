class Ingredient
  include Mongoid::Document

  field :quantity
  field :name

  embedded_in :recipe, :inverse_of => :ingredients

  validates_presence_of :name
  after_save :parse_quantity

  scope :search, lambda { |query|
    if query.blank?
      where(:id => 0)
    else
      where('UPPER(name) LIKE ?', "%#{query.upcase}%")
    end
  }

end
