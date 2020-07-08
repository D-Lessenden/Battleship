require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_coordinate_exists
    assert_instance_of Cell, @cell
  end

  def test_where_da_cell_at
    assert_equal "B4", @cell.coordinate
  end

  def test_what_is_in_cell
     assert_equal nil, @cell.ship
  end

  def test_is_empty?
    assert_equal true, @cell.empty?
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end

  def test_place_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_fired_upon?
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_fire
    @cell.place_ship(@cruiser)
    assert_equal 3, @cruiser.health
    @cell.fire_upon
    assert_equal 2, @cruiser.health
    @cell.fire_upon
    assert_equal 1, @cruiser.health
    @cell.fire_upon
    assert_equal true, @cruiser.sunk?
  end

  def test_cell_can_render
    @cell.place_ship(@cruiser)
    assert_equal ".", @cell.render

    @cell.fire_upon
    assert_equal "H", @cell.render

    @cell.fire_upon
    @cell.fire_upon
    assert_equal "X", @cell.render
  end

  def test_cell_can_render_a_miss
    @cell2 = Cell.new("C4")
    @cell.place_ship(@crauiser)
    @cell2.fire_upon
    assert_equal "M", @cell2.render
  end
end
