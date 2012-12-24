class Category
  include Mongoid::Document

  field :name

  # search_in :name
  scope :search, lambda { |q| where(:name => /#{q}/i) }

  has_many :recipes

  validates_presence_of :name
  validates_uniqueness_of :name
end
