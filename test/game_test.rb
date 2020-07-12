require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
    @board = Board.new
    @board.generate_cells
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @sub = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_cpu_place_cruiser
    refute nil, @game.cpu_place_cruiser
    refute nil, @game.cpu_place_sub
  end


  def test_cpu_fire
    #skip
    #@board.cells["A2"]
    @board.verify_and_fire("A1")
    @board.verify_and_fire("A2")
    @board.verify_and_fire("A3")
    @board.verify_and_fire("A4")
    @board.verify_and_fire("B1")
    @board.verify_and_fire("B2")
    @board.verify_and_fire("B3")
    @board.verify_and_fire("B4")
    @board.verify_and_fire("C1")
    @board.verify_and_fire("C2")
    @board.verify_and_fire("C3")
    @board.verify_and_fire("C4")
    @board.verify_and_fire("D1")
    @board.verify_and_fire("D2")
    @board.verify_and_fire("D3")
     #binding.pry
    # @board.verify_and_fire("D1")


    assert_equal "D4", @game.cpu_fire
  end
  #
  def test_game_over_p1_win
    @cpu_cruiser.hit
    @cpu_cruiser.hit
    @cpu_cruiser.hit
    @cpu_sub.hit
    @cpu_sub.hit
    assert_equal true, @cpu_sub.sunk?
    assert_equal true, @cpu_cruiser.sunk?
    assert_equal "You won!", @game.human_win
  end

  def test_game_over_cpu_win
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    @sub.hit
    @sub.hit
    assert_equal true, @sub.sunk?
    assert_equal true, @cruiser.sunk?
    assert_equal "Computer win!", @game.cpu_win
  end

end
