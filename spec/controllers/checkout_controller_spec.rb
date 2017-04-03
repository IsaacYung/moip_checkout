require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do

  describe "GET #custumer" do
    it "returns http success" do
      get :custumer
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #payment" do
    it "returns http success" do
      get :payment
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #confirm" do
    it "returns http success" do
      get :confirm
      expect(response).to have_http_status(:success)
    end
  end

end
