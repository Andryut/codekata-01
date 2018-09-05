require_relative './../source'

RSpec.describe ShoppingCart do
  it 'calculates totals' do
    cart = ShoppingCart.new

    p1 = Product.new 1.99
    p2 = Product.new 2.99

    cart << (ProductWithQuantity.new p1, 2)
    cart << (ProductWithQuantity.new p2, 20)

    expect(cart.total).to be_within(0.01).of(63.78)
  end
end
