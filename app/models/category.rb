class Category
  include Mongoid::Document

  field :name

  references_many :recipes

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :search, lambda { |query|
    if query.blank?
      where(:id => 0)
    else
      where('UPPER(name) LIKE ?', "%#{query.upcase}%")
    end
  }
end
