require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :product_name => "MyString",
      :quantity => 1,
      :detail => "MyString",
      :price => 1
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_product_name[name=?]", "product[product_name]"

      assert_select "input#product_quantity[name=?]", "product[quantity]"

      assert_select "input#product_detail[name=?]", "product[detail]"

      assert_select "input#product_price[name=?]", "product[price]"
    end
  end
end
