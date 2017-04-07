module ApplicationHelper
  def BRL(price)
    price = '%.2f' % (price.to_f/100)
    price.to_s.gsub('.', ',')
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
