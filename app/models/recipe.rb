class Recipe < ActiveRecord::Base
  has_many :ingredients
  belongs_to :category

  validates_presence_of :name, :directions, :slug
  validates_uniqueness_of :name, :slug

  before_validation :set_slug_from_name

  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank,
      :allow_destroy => true
  accepts_nested_attributes_for :category, :reject_if => :all_blank

  scope :search, lambda { |query|
    if query.blank? 
      where(:id => 0) # no results
    else
      joins(:ingredients, :category).where('categories.name LIKE :q ' +
        'OR ingredients.name LIKE :q OR recipes.name LIKE :q',
        :q => "%#{query}%"
      )
    end
  }

  def to_param
    self[:slug]
  end
  
  protected
  
  def set_slug_from_name
    self[:slug] = self[:name].parameterize
  end
end
