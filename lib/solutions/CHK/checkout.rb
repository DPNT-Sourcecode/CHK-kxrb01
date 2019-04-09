# noinspection RubyUnusedLocalVariable
class Checkout
  PRICES = {A: 50, B: 30, C: 20, D: 15}
  OFFERS = {AAA: 130, BB: 45}
 #  A    | 50    | 3A for 130     |
 # | B    | 30    | 2B for 45      |
 # | C    | 20    |                |
 # | D    | 15
  def checkout(skus)
    @skus = skus
    @total_price = 0
    @skus.split("").each do |item|
      @total_price = @total_price + PRICES[item.to_sym]
    end
    apply_offers()
    return @total_price
  end

  def apply_offers
    sorted_basket = @skus.split("").sort.join("")
    OFFERS.each do |key, value|
      if sorted_basket.include? key.to_s
        key.to_s.split("").each do |item|
          @total_price = @total_price - PRICES[item.to_sym]
        end
        @total_price = @total_price + OFFERS[key]
      end
    end
  end
end
