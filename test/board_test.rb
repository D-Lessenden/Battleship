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
    assert true, @board.valid_coordinate?("A1")

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

end
