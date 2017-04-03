module ApplicationHelper
  def BRL(price)
    price = '%.2f' % (price.to_f/100)
    price.to_s.gsub('.', ',')
  end
end
