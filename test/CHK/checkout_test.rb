require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test
  # def test_total_price_is_115_of_basket_with_ABCD
  #   assert_equal 115, Checkout.new.checkout('ABCD')
  # end
  #
  # def test_total_price_is_145_of_basket_with_AAAD
  #   assert_equal 145, Checkout.new.checkout('AAAD')
  # end
  #
  # def test_total_price_is_250_of_basket_with_AAAAAA
  #   assert_equal 250, Checkout.new.checkout('AAAAAA')
  # end
  #
  # def test_total_price_is_305_of_basket_with_BAAAAAAB
  #   assert_equal 295, Checkout.new.checkout('BAAAAAAB')
  # end
  #
  # def test_total_price_is_350_of_basket_with_BAAAAAABDDD
  #   assert_equal 340, Checkout.new.checkout('BAAAAAABDDD')
  # end
  #
  # def test_minus_one_is_returned_when_passed_a_basket_with_a
  #   assert_equal -1, Checkout.new.checkout('a')
  # end
  #
  # def test_minus_one_is_returned_when_passed_a_basket_with_hyphen
  #   assert_equal -1, Checkout.new.checkout('-')
  # end
  #
  # def test_minus_one_is_returned_when_passed_a_basket_with_ABCa
  #   assert_equal -1, Checkout.new.checkout('ABCa')
  # end
  #
  # def test_total_price_is_40_of_basket_with_E
  #   assert_equal 40, Checkout.new.checkout('E')
  # end
  #
  # def test_total_price_is_80_of_basket_with_EEB
  #   assert_equal 80, Checkout.new.checkout('EEB')
  # end
  #
  # def test_total_price_is_160_of_basket_with_EEBEE
  #   assert_equal 160, Checkout.new.checkout('EEBEE')
  # end
  #
  # def test_total_price_is_160_of_basket_with_BAAAAAABDDDEEBEE
  #   assert_equal 485, Checkout.new.checkout('BAAAAAABDDDEEBEE')
  # end
  #
  # def test_total_price_is_835_of_basket_with_BAAAAAABDDDEEBEECDAACCDBBBBEEE
  #   assert_equal 835, Checkout.new.checkout('BAAAAAABDDDEEBEECDAACCDBBBBEEE')
  # end

  def test_total_price_is_835_of_basket_with_AAAAAAAAAAA
    assert_equal 450, Checkout.new.checkout('AAAAAAAAAAA')
  end
end
