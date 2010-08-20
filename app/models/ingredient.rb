class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates_presence_of :name, :quantity
  after_save :parse_quantity
  
  def parsed_quantity
    Marshal.load self[:parsed_quantity]
  end
  
  protected
  
  def parse_quantity
    return if quantity.blank?
    quantity, unit = quantity.split ' '

    quantity = Rational(*(quantity.split('/').map(&:to_i))).to_f

    parsed_quantity = begin
      quantity.send unit.gsub(/\W/, '')
    rescue NoMethodError
      nil
    end
    
    self[:parsed_quantity] = Marshal.dump parsed_quantity
  end
end
