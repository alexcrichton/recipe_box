class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates_presence_of :name
  after_save :parse_quantity

  scope :search, lambda { |query| 
    if query.blank?
      where(:id => 0)
    else
      where('UPPER(name) LIKE ?', "%#{query.upcase}%")
    end
  }

  def parsed_quantity
    Marshal.load self[:parsed_quantity]
  rescue
    nil
  end
  
  protected
  
  def parse_quantity
    # TODO: get this working again
    # return if quantity.blank?
    # quantity, unit = self[:quantity].split ' '
    # 
    # quantity = Rational(*(quantity.split('/').map(&:to_i))).to_f
    # 
    # parsed_quantity = begin
    #   quantity.send unit.gsub(/\W/, '')
    # rescue NoMethodError
    #   nil
    # end
    # 
    # self[:parsed_quantity] = Marshal.dump parsed_quantity
  end
end
