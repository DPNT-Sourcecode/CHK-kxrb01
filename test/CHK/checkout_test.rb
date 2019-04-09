require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test
  def test_total_price_is_115_of_basket_with_ABCD
    assert_equal 115, Checkout.new.checkout('ABCD')
  end

  def test_total_price_is_145_of_basket_with_AAAD
    assert_equal 145, Checkout.new.checkout('AAAD')
  end

  def test_total_price_is_260_of_basket_with_AAAAAA
    assert_equal 260, Checkout.new.checkout('AAAAAA')
  end
end
