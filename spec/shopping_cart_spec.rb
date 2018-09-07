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

    expect(cart.total).to be_within(0.01).of(200.5)
  end

  it 'calculates promotions' do
    cart = ShoppingCart.new

    p1 = Product.by_unit 1.99
    p1.offer = Offer.new quantity: 3, price: 3, product: p1

    cart << (ProductWithQuantity.new p1, 4)

    expect(cart.total).to be_within(0.01).of(4.99)
  end


  it 'calculates selling price and cost of stock' do
    stock = Stock.new

    p1 = Product.by_unit 1.99, 1
    p1.offer = Offer.new quantity: 3, price: 3, product: p1

    stock << (ProductWithQuantity.new p1, 20_000)

    expect(stock.total_cost).to be_within(0.01).of(20_000)
    expect(stock.total_selling_price).to be_within(0.01).of(20001.98)
  end

  it 'calculates selling price and cost of stock of a product by kg' do
    stock = Stock.new

    p1 = Product.by_kg 1.99, 1
    # p1.offer = Offer.new quantity: 3, price: 3, product: p1

    stock << (ProductWithQuantity.new p1, 20_000)

    expect(stock.total_cost).to be_within(0.01).of(20)
    expect(stock.total_selling_price).to be_within(0.01).of(39.8)
  end
end
