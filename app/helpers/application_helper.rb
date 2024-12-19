
module ApplicationHelper
  def formatted_price(price)
    number_with_delimiter(price, delimiter: ".", separator: ",")
  end
end
