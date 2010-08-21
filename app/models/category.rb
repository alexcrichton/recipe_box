class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  scope :search, lambda { |query| 
    if query.blank?
      where(:id => 0)
    else
      where('name LIKE ?', "%#{query}%")
    end
  }
end
