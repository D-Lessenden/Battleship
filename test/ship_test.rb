require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_ship_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_health
    @cruiser.health
    assert_equal 3, @cruiser.health

    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_has_it_sunk?
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
