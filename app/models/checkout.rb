class Checkout
  def initialize
    auth = Moip2::Auth::Basic.new("G3B6XAH0KBCAMEE0O1LZALCB786FNHQ5", "W8EBLTSUWA6BENQO68YN3A9KAQ2PJERATS0GNLYY")
    client = Moip2::Client.new(:sandbox, auth)
    @api = Moip2::Api.new(client)
  end

  def create_order(order, customer)
    item_ids ||= []
    order.product_movements.each do |item|
      item_ids << item.product_id;
    end

    products = Product.find(item_ids)

    items ||= []
    products.each do |item|
      items << {
        product: item.product_name,
        quantity: 1,
        detail: item.detail,
        price: item.price
      }
    end

    order_json = {
      own_id: order.id,
      items: items,
      customer: {
        own_id: customer.id,
        fullname: customer.fullname,
        email: customer.email,
      }
    }

    @api.order.create(order_json)
  end

  def show_order(order_id)
    @api.order.show(order_id)
  end

  def create_payment(order, payment)
    credit_card_payment = {
      installment_count: payment[:instalment_count].to_i,
      funding_instrument: {
        method: "CREDIT_CARD",
         credit_card: {
         expiration_month: payment[:expiration_month],
         expiration_year: payment[:expiration_year],
         number: payment[:card_number],
         cvc: payment[:cvc],
           holder: {
             fullname: payment[:holder_name],
             birthdate: payment[:holder_birthdate],
             tax_document: {
               type: "CPF",
               number: payment[:cpf]
             },
              phone: {
                country_code: "55",
                area_code: "11",
                number: payment[:phone]
              }
            }
          }
        }
      }

      @api.payment.create(order.external_id, credit_card_payment)
  end
end
