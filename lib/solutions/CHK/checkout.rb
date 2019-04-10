# noinspection RubyUnusedLocalVariable
# | G    | 20    |                        |
# | H    | 10    | 5H for 45, 10H for 80  |
# | I    | 35    |                        |
# | J    | 60    |                        |
# | K    | 80    | 2K for 150             |
# | L    | 90    |                        |
# | M    | 15    |                        |
# | N    | 40    | 3N get one M free      |
# | O    | 10    |                        |
# | P    | 50    | 5P for 200             |
# | Q    | 30    | 3Q for 80              |
# | R    | 50    | 3R get one Q free      |
# | S    | 30    |                        |
# | T    | 20    |                        |
# | U    | 40    | 3U get one U free      |
# | V    | 50    | 2V for 90, 3V for 130  |
# | W    | 20    |                        |
# | X    | 90    |                        |
# | Y    | 10    |                        |
# | Z    | 50    |                        |
# +------+-------+------------------------+

class Checkout
  ITEMS = ['A', 'B', 'C', 'D', 'E', 'F']
  PRICES = [{item: 'A', count: 1, price: 50}, {item: 'B', count: 1, price: 30},
            {item: 'C', count: 1, price: 20}, {item: 'D', count: 1, price: 15},
            {item: 'E', count: 1, price: 40}, {item: 'F', count: 1, price: 10},
            {item: 'G', count: 1, price: 20}, {item: 'H', count: 1, price: 10},
            {item: 'I', count: 1, price: 35}, {item: 'J', count: 1, price: 60},
            {item: 'K', count: 1, price: 80}, {item: 'L', count: 1, price: 90},
            {item: 'M', count: 1, price: 15}, {item: 'N', count: 1, price: 40},
            {item: 'O', count: 1, price: 10}, {item: 'P', count: 1, price: 50},
            {item: 'Q', count: 1, price: 30}, {item: 'R', count: 1, price: 50},
            {item: 'S', count: 1, price: 30}, {item: 'T', count: 1, price: 20},
            {item: 'G', count: 1, price: 20}, {item: 'H', count: 1, price: 10},
            {item: 'G', count: 1, price: 20}, {item: 'H', count: 1, price: 10},
            {item: 'G', count: 1, price: 20}, {item: 'H', count: 1, price: 10},
            ]
  MULTIBUY_OFFERS = [{item: 'A', count: 3, offer_price: 130},
                     {item: 'B', count: 2, offer_price: 45},
                     {item: 'A', count: 5, offer_price: 200},
                      {item: 'F', count: 3, offer_price: 20}]
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
          number_of_offers = 0
          if basket_item[:count] >= offer[:count]
            number_of_offers = basket_item[:count] / offer[:count]
            @total_price += (offer[:offer_price] * number_of_offers)
            basket_item[:count] -= (offer[:count] * number_of_offers)
          end
        end
      end
    end
  end

  def apply_normal_price
    @basket.each do |basket_item|
      PRICES.each do |item_detail|
        if item_detail[:item] == basket_item[:item]
            @total_price += (item_detail[:price] * basket_item[:count])
        end
      end
    end
  end

  def apply_combo_offers
    @basket.each do |basket_item|
      COMBO_OFFERS.each do |item_detail|
        if item_detail[:item] == basket_item[:item]
          number_of_possible_combo_offers = 0
          if basket_item[:count] >= item_detail[:count]
            number_of_possible_combo_offers = basket_item[:count] / item_detail[:count]
            free_item = @basket.select {|element| element[:item] == item_detail[:free_item]}.first
            if free_item != nil
              #reduce the quantity of the free item in the basket
              if free_item[:count] >= number_of_possible_combo_offers
                free_item[:count] -= number_of_possible_combo_offers
              elsif free_item[:count] > 0
                free_item[:count] = 0
              end
            end
          end
        end
      end
    end
  end
end

