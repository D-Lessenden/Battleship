require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
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

  end



end
