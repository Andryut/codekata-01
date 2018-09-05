class Product

  attr_reader :price, :unit_type

  def initialize price, unit_type
    @price = price
    @unit_type = unit_type
  end


  def self.by_unit price
    Product.new price, :unit
  end

  def self.by_kg price
    Product.new price, :kg
  end

  def price_for quantity
    if @unit_type == :kg
      @price * quantity / 1000
    else
      @price * quantity
    end
  end

end

class ProductWithQuantity

  def initialize product, quantity
    @product = product
    @quantity = quantity
  end

  def total
    @product.price_for(@quantity)
  end

end


class ShoppingCart

  def initialize
    @products = []
  end

  def << product
    @products << product
  end

  def total
    @products.reduce(0) { |sum, product| product.total + sum  }
  end

end