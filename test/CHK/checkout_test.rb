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

  def test_total_price_is_250_of_basket_with_AAAAAA
    assert_equal 250, Checkout.new.checkout('AAAAAA')
  end

  def test_total_price_is_305_of_basket_with_BAAAAAAB
    assert_equal 295, Checkout.new.checkout('BAAAAAAB')
  end

  def test_total_price_is_350_of_basket_with_BAAAAAABDDD
    assert_equal 340, Checkout.new.checkout('BAAAAAABDDD')
  end

  def test_minus_one_is_returned_when_passed_a_basket_with_a
    assert_equal (-1), Checkout.new.checkout('a')
  end

  def test_minus_one_is_returned_when_passed_a_basket_with_hyphen
    assert_equal (-1), Checkout.new.checkout('-')
  end

  def test_minus_one_is_returned_when_passed_a_basket_with_ABCa
    assert_equal (-1), Checkout.new.checkout('ABCa')
  end

  def test_total_price_is_40_of_basket_with_E
    assert_equal 40, Checkout.new.checkout('E')
  end

  def test_total_price_is_80_of_basket_with_EEB
    assert_equal 80, Checkout.new.checkout('EEB')
  end

  def test_total_price_is_160_of_basket_with_EEBEE
    assert_equal 160, Checkout.new.checkout('EEBEE')
  end

  def test_total_price_is_160_of_basket_with_BAAAAAABDDDEEBEE
    assert_equal 485, Checkout.new.checkout('BAAAAAABDDDEEBEE')
  end

  def test_total_price_is_835_of_basket_with_BAAAAAABDDDEEBEECDAACCDBBBBEEE
    assert_equal 835, Checkout.new.checkout('BAAAAAABDDDEEBEECDAACCDBBBBEEE')
  end

  def test_total_price_is_450_of_basket_with_AAAAAAAAAAA
    assert_equal 450, Checkout.new.checkout('AAAAAAAAAAA')
  end

  def test_total_price_is_20_of_basket_with_FFF
    assert_equal 20, Checkout.new.checkout('FFF')
  end

  def test_total_price_is_155_of_basket_with_FFFABCDFF
    assert_equal 155, Checkout.new.checkout('FFFABCDFF')
  end

  def test_total_price_is_875_of_basket_with_BAAAAAABDDDEEBEECDAACCDBBBBEEEFFFFF
    assert_equal 875, Checkout.new.checkout('BAAAAAABDDDEEBEECDAACCDBBBBEEEFFFFF')
  end

  def test_total_price_is_10_of_basket_with_H
    assert_equal 10, Checkout.new.checkout('H')
  end

  def test_total_price_is_35_of_basket_with_I
    assert_equal 35, Checkout.new.checkout('I')
  end

  def test_total_price_is_60_of_basket_with_J
    assert_equal 60, Checkout.new.checkout('J')
  end

  def test_total_price_is_80_of_basket_with_K
    assert_equal 80, Checkout.new.checkout('K')
  end

  def test_total_price_is_90_of_basket_with_L
    assert_equal 90, Checkout.new.checkout('L')
  end

  def test_total_price_is_15_of_basket_with_M
    assert_equal 15, Checkout.new.checkout('M')
  end

  def test_total_price_is_15_of_basket_with_N
    assert_equal 40, Checkout.new.checkout('N')
  end

  def test_total_price_is_10_of_basket_with_O
    assert_equal 10, Checkout.new.checkout('O')
  end

  def test_total_price_is_50_of_basket_with_P
    assert_equal 50, Checkout.new.checkout('P')
  end

  def test_total_price_is_30_of_basket_with_Q
    assert_equal 30, Checkout.new.checkout('Q')
  end

  def test_total_price_is_50_of_basket_with_R
    assert_equal 50, Checkout.new.checkout('R')
  end

  def test_total_price_is_30_of_basket_with_S
    assert_equal 30, Checkout.new.checkout('S')
  end

  def test_total_price_is_20_of_basket_with_T
    assert_equal 20, Checkout.new.checkout('T')
  end

  def test_total_price_is_40_of_basket_with_U
    assert_equal 40, Checkout.new.checkout('U')
  end

  def test_total_price_is_50_of_basket_with_V
    assert_equal 50, Checkout.new.checkout('V')
  end

  def test_total_price_is_20_of_basket_with_W
    assert_equal 20, Checkout.new.checkout('W')
  end

  def test_total_price_is_90_of_basket_with_X
    assert_equal 90, Checkout.new.checkout('X')
  end

  def test_total_price_is_10_of_basket_with_Y
    assert_equal 10, Checkout.new.checkout('Y')
  end

  def test_total_price_is_50_of_basket_with_Z
    assert_equal 50, Checkout.new.checkout('Z')
  end
  #   H    | 10    | 5H for 45, 10H for 80  |
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


end
