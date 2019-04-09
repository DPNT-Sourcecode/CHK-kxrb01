# noinspection RubyUnusedLocalVariable
class Checkout
  PRICES = [{item: 'A', count: 1, price: 50}, {item: 'B', count: 1, price: 30}, {item: 'C', count: 1, price: 20}, {item: 'D', count: 1, price: 15}]
  OFFERS = [{item: 'A', count: 3, offer_price: 130}, {item: 'B', count: 2, offer_price: 45}]
 #  A    | 50    | 3A for 130     |
 # | B    | 30    | 2B for 45      |
 # | C    | 20    |                |
 # | D    | 15
  def checkout(skus)
    @skus = skus
    @total_price = 0
    # @skus.split("").each do |item|
    #   @total_price = @total_price + PRICES[item.to_sym]
    # end
    apply_offers()
    apply_normal_price()
    return @total_price
  end

  def apply_offers
    @basket = []
    sku_array = @skus.split("")
    sku_array.uniq.each do |item|
      basket_item = {:item => item, :count => sku_array.count(item)}
      @basket << basket_item
    end
    @basket.each do |basket_item|
      OFFERS.each do |offer|
        if offer[:item] == basket_item[:item]
          while offer[:count] <= basket_item[:count]
            p "total price"
            p @total_price += offer[:offer_price]
            basket_item[:count] -= offer[:count]
          end
        end
      end
    end
    # sorted_basket = @skus.split("").sort.join("")
    # OFFERS.each do |key, value|
    #   if sorted_basket.include? key.to_s
    #     key.to_s.split("").each do |item|
    #       @total_price = @total_price - PRICES[item.to_sym]
    #     end
    #     @total_price = @total_price + OFFERS[key]
    #   end
    # end
  end
  def apply_normal_price
    @basket.each do |basket_item|
      PRICES.each do |item_detail|
        if item_detail[:item] == basket_item[:item]
          while item_detail[:count] <= basket_item[:count]
            p "total price"
            p @total_price += item_detail[:offer_price]
            basket_item[:count] -= offer[:count]
          end
        end
      end
    end
  end
end




