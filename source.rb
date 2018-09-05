class Product

  attr_reader :price

  def initialize price
    @price = price
  end

end

class ProductWithQuantity

  def initialize product, quantity
    @product = product
    @quantity = quantity
  end

  def total
    @product.price * @quantity
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