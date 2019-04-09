require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test
  def test_total_price_of_basket_with_ABCD
    assert_equal 115, Checkout.new.checkout('ABCD')
  end
end

