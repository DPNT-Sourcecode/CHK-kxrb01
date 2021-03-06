# noinspection RubyUnusedLocalVariable
class Checkout
  ITEMS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
           'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ]
  PRICES = [{item: 'A', count: 1, price: 50}, {item: 'B', count: 1, price: 30},
            {item: 'C', count: 1, price: 20}, {item: 'D', count: 1, price: 15},
            {item: 'E', count: 1, price: 40}, {item: 'F', count: 1, price: 10},
            {item: 'G', count: 1, price: 20}, {item: 'H', count: 1, price: 10},
            {item: 'I', count: 1, price: 35}, {item: 'J', count: 1, price: 60},
            {item: 'K', count: 1, price: 70}, {item: 'L', count: 1, price: 90},
            {item: 'M', count: 1, price: 15}, {item: 'N', count: 1, price: 40},
            {item: 'O', count: 1, price: 10}, {item: 'P', count: 1, price: 50},
            {item: 'Q', count: 1, price: 30}, {item: 'R', count: 1, price: 50},
            {item: 'S', count: 1, price: 20}, {item: 'T', count: 1, price: 20},
            {item: 'U', count: 1, price: 40}, {item: 'V', count: 1, price: 50},
            {item: 'W', count: 1, price: 20}, {item: 'X', count: 1, price: 17},
            {item: 'Y', count: 1, price: 20}, {item: 'Z', count: 1, price: 21},
            ]
  MULTIBUY_OFFERS = [{item: 'A', count: 3, offer_price: 130},
                     {item: 'B', count: 2, offer_price: 45},
                     {item: 'A', count: 5, offer_price: 200},
                     {item: 'F', count: 3, offer_price: 20},
                     {item: 'H', count: 5, offer_price: 45},
                     {item: 'H', count: 10, offer_price: 80},
                     {item: 'K', count: 2, offer_price: 120},
                     {item: 'P', count: 5, offer_price: 200},
                     {item: 'Q', count: 3, offer_price: 80},
                     {item: 'U', count: 4, offer_price: 120},
                     {item: 'V', count: 2, offer_price: 90},
                     {item: 'V', count: 3, offer_price: 130}
                    ]
  COMBO_OFFERS = [{item: 'E', count: 2, free_item: 'B'},
                  {item: 'N', count: 3, free_item: 'M'},
                  {item: 'R', count: 3, free_item: 'Q'}
                 ]

  GROUP_DISCOUNT_OFFER = {items: ['S', 'T', 'X', 'Y', 'Z'], count: 3, offer_price: 45}

  def checkout(skus)
    @skus = skus
    @total_price = 0
    skus.split("").uniq.each do |item|
      return -1 if !ITEMS.include? item
    end
    structure_basket()
    apply_group_discounts()
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

  def apply_group_discounts
    number_of_group_discount_items = 0
    discount_basket_items = []
    @basket.each do |basket_item|
        if GROUP_DISCOUNT_OFFER[:items].include? basket_item[:item]
          number_of_group_discount_items += basket_item[:count]
          basket_item_price = 0
          PRICES.each do |item_detail|
            if item_detail[:item] == basket_item[:item]
              basket_item_price = item_detail[:price]
            end
          end
          discount_basket_items << {item: basket_item[:item],
            count: basket_item[:count], price: basket_item_price}

        end
    end

    if number_of_group_discount_items >= GROUP_DISCOUNT_OFFER[:count]
      number_of_group_discount_offers = number_of_group_discount_items / GROUP_DISCOUNT_OFFER[:count]

      @total_price += (GROUP_DISCOUNT_OFFER[:offer_price] * number_of_group_discount_offers)
      total_qty_to_reduce = number_of_group_discount_offers * GROUP_DISCOUNT_OFFER[:count]
      sorted_discount_basket_items = discount_basket_items.sort_by{|a_discount_item| a_discount_item[:price]}.reverse
      sorted_discount_basket_items.each do |sorted_basket_item|
        if total_qty_to_reduce > 0
          if sorted_basket_item[:count] >= total_qty_to_reduce
            sorted_basket_item[:count] -= total_qty_to_reduce
            total_qty_to_reduce = 0
          else
            total_qty_to_reduce -= sorted_basket_item[:count]
            sorted_basket_item[:count] = 0
          end
        end
      end
      sorted_discount_basket_items.each do |discount_item|
        @basket.select{|element| element[:item] == discount_item[:item]}.first[:count] = discount_item[:count]
      end
    end
  end
end
