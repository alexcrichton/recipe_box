class Category
  include Mongoid::Document
  include Mongoid::Search

  field :name

  search_in :name

  references_many :recipes

  validates_presence_of :name
  validates_uniqueness_of :name
end
