# noinspection RubyUnusedLocalVariable
class Checkout
  PRICES = {A: 50, B: 30, C: 20, D: 15}
 #  A    | 50    | 3A for 130     |
 # | B    | 30    | 2B for 45      |
 # | C    | 20    |                |
 # | D    | 15
  def checkout(skus)
    total_price = 0
    skus.split("").each do |item|
      total_price = total_price + PRICES[item.to_sym]
    end
    return total_price
  end
end

