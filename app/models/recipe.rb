class Recipe
  include Mongoid::Document

  field :directions
  field :name
  field :slug

  embeds_many :ingredients
  embeds_many :comments

  referenced_in :category
  referenced_in :user

  validates_associated :category
  validates_presence_of :name, :directions, :slug, :user_id
  validates_uniqueness_of :name, :slug, :scope => :user_id

  before_validation :set_slug_from_name

  ALL_BLANK = Proc.new{ |h| h.all?{ |_, v| v.blank? } }

  accepts_nested_attributes_for :ingredients, :reject_if => ALL_BLANK,
      :allow_destroy => true

  scope :search, lambda { |query|
    if query.blank?
      where(:id => 0) # no results
    else
      joins(:ingredients, :category).where('UPPER(categories.name) LIKE :q ' +
        'OR UPPER(ingredients.name) LIKE :q OR UPPER(recipes.name) LIKE :q',
        :q => "%#{query.upcase}%"
      ).group(Recipe.column_names.map{ |c| "recipes.#{c}" }) # for postgresql
    end
  }

  def self.find_by_slug! slug
    where(:slug => slug).first or raise Mongoid::Errors::DocumentNotFound
  end

  def category_name
    category.try(:name)
  end

  def to_param
    self[:slug]
  end

  protected

  def set_slug_from_name
    self[:slug] = self[:name].parameterize unless self[:name].blank?
  end
end
