require_relative './../source'

RSpec.describe ShoppingCart do
  it 'calculates totals' do
    cart = ShoppingCart.new

    p1 = Product.by_unit 1.99
    p2 = Product.by_unit 2.99

    cart << (ProductWithQuantity.new p1, 2)
    cart << (ProductWithQuantity.new p2, 20)

    expect(cart.total).to be_within(0.01).of(63.78)
  end
  it 'calculates totals with weight products' do
    cart = ShoppingCart.new

    p1 = Product.by_unit 1.99
    p2 = Product.by_kg 2.99

    cart << (ProductWithQuantity.new p1, 100)
    cart << (ProductWithQuantity.new p2, 500)

    expect(cart.total).to be_within(0.01).of(200.49)
  end
end
