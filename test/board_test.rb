require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_valid_coord
    @board.cells
    @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("A1")

    @board.valid_coordinate?("D4")
    assert true, @board.valid_coordinate?("D4")

    @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("A5")

    @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("E1")
    #Not sure if syntax on line 26 or line 29 is better

    @board.valid_coordinate?("A22")
    refute @board.valid_coordinate?("A22")
    binding.
  end

   def test_valid_placement
     @board.cells
     submarine = Ship.new("Submarine", 2)
     cruiser = Ship.new("Cruiser", 3)
    # binding.pry

     assert_equal true, @board.valid_placement?(submarine, ["B2", "B3"])
     assert_equal true, @board.valid_placement?(cruiser, ["A2", "A3", "A4"])
     assert_equal false, @board.valid_placement?(submarine, ["D2", "D3", "D4"])
   end



   def test_consecutive
     @board.cells
     submarine = Ship.new("Submarine", 2)
     cruiser = Ship.new("Cruiser", 3)

     assert_equal "bla", @board.consecutive(submarine, ["A2", "A3"])
   end

end
