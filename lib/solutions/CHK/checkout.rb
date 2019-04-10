# noinspection RubyUnusedLocalVariable
class Checkout
  ITEMS = ['A', 'B', 'C', 'D', 'E']
  PRICES = [{item: 'A', count: 1, price: 50}, {item: 'B', count: 1, price: 30}, {item: 'C', count: 1, price: 20}, {item: 'D', count: 1, price: 15}, {item: 'E', count: 1, price: 40}]
  MULTIBUY_OFFERS = [{item: 'A', count: 3, offer_price: 130}, {item: 'B', count: 2, offer_price: 45}, {item: 'A', count: 5, offer_price: 200}]
  COMBO_OFFERS = [{item: 'E', count: 2, free_item: 'B'}]

  def checkout(skus)
    @skus = skus
    @total_price = 0
    skus.split("").uniq.each do |item|
      return -1 if !ITEMS.include? item
    end
    structure_basket()
    apply_combo_offers()
    apply_multibuy_offers()
    apply_normal_price()
    return @total_price
  end

  def structure_basket
    @basket = []
    sku_array = @skus.split("")
    sku_array.uniq.each do |item|
      basket_item = {:item => item, :count => sku_array.count(item)}
      @basket << basket_item
    end
  end

  def apply_multibuy_offers
    @basket.each do |basket_item|
      MULTIBUY_OFFERS.sort_by{|an_offer| an_offer[:count]}.reverse.each do |offer|
        if offer[:item] == basket_item[:item]
          while offer[:count] <= basket_item[:count]
            @total_price += offer[:offer_price]
            basket_item[:count] -= offer[:count]
          end
        end
      end
    end
  end

  def apply_normal_price
    @basket.each do |basket_item|
      PRICES.each do |item_detail|
        if item_detail[:item] == basket_item[:item]
          while item_detail[:count] <= basket_item[:count]
            @total_price += item_detail[:price]
            basket_item[:count] -= item_detail[:count]
          end
        end
      end
    end
  end

  def apply_combo_offers
    @basket.each do |basket_item|
      COMBO_OFFERS.each do |item_detail|
        if item_detail[:item] == basket_item[:item]
          while item_detail[:count] <= basket_item[:count]
            if @basket.select {|element| element[:item] == item_detail[:free_item]}.first != nil
              #reduce the quantity of the free item in the basket by 1
              @basket.select {|element| element[:item] == item_detail[:free_item]}.first[:count] -= 1
              PRICES.select{|an_item| an_item[:item] == item_detail[:item] }.first[:price] * item_detail[:count]
              @total_price += (PRICES.select{|an_item| an_item[:item] == item_detail[:item] }.first[:price] * item_detail[:count])
              basket_item[:count] -= item_detail[:count]
            end
          end
        end
      end
    end
  end
end


