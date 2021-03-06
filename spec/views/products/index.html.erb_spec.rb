require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :product_name => "Product Name",
        :quantity => 2,
        :detail => "Detail",
        :price => 3
      ),
      Product.create!(
        :product_name => "Product Name",
        :quantity => 2,
        :detail => "Detail",
        :price => 3
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Product Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Detail".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
