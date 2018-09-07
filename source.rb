class Product

  attr_reader :price, :unit_type, :cost
  attr_accessor :offer

  def initialize price, unit_type, cost
    @price = price
    @unit_type = unit_type
    @cost = cost
  end


  def self.by_unit price, cost=nil
    Product.new price, :unit, cost
  end

  def self.by_kg price, cost=nil
    Product.new price, :kg, cost
  end

  def price_for quantity
    if @unit_type == :kg
      @price * quantity / 1000
    else
      @price * quantity
    end
  end

  def cost_for quantity
    if @unit_type == :kg
      @cost * quantity / 1000
    else
      @cost * quantity
    end
  end

end

class ProductWithQuantity

  def initialize product, quantity
    @product = product
    @quantity = quantity
  end

  def total
    return @product.price_for(@quantity) if @product.offer.nil?

    @product.offer.total_for @quantity
  end

  def cost
    @product.cost_for @quantity
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


class Offer

  def initialize quantity: , price:, product:
    @group_quantity = quantity
    @group_price = price
    @product = product
  end

  def total_for quantity
    qty = quantity
    price = 0
    until qty < @group_quantity
      price += @group_price
      qty -= @group_quantity
    end

    price + @product.price_for(qty)
  end

end


class Stock

  def initialize
    @products = []
  end

  def << product
    @products << product
  end

  def total_selling_price
    @products.reduce(0) { |sum, product| product.total + sum  }
  end

  def total_cost
    @products.reduce(0) { |sum, product| product.cost + sum  }
  end

end