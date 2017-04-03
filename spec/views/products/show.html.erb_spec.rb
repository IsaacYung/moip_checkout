require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :product_name => "Product Name",
      :quantity => 2,
      :detail => "Detail",
      :price => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Product Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Detail/)
    expect(rendered).to match(/3/)
  end
end
