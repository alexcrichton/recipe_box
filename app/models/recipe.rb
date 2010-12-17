class Recipe
  include Mongoid::Document
  include Mongoid::Search

  field :directions
  field :name
  field :slug

  embeds_many :ingredients
  embeds_many :comments

  referenced_in :category
  referenced_in :user

  search_in :name, :category => :name, :ingredients => :name

  validates_associated :category
  validates_presence_of :name, :directions, :slug, :user_id
  validates_uniqueness_of :name, :slug, :scope => :user_id

  before_validation :set_slug_from_name

  ALL_BLANK = Proc.new{ |h| h.all?{ |_, v| v.blank? } }

  accepts_nested_attributes_for :ingredients, :reject_if => ALL_BLANK,
      :allow_destroy => true

  def self.find_by_slug! slug
    where(:slug => slug).first or
      raise Mongoid::Errors::DocumentNotFound.new(self.class, :slug => slug)
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
