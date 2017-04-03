require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :product_name => "MyString",
      :quantity => 1,
      :detail => "MyString",
      :price => 1
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_product_name[name=?]", "product[product_name]"

      assert_select "input#product_quantity[name=?]", "product[quantity]"

      assert_select "input#product_detail[name=?]", "product[detail]"

      assert_select "input#product_price[name=?]", "product[price]"
    end
  end
end
