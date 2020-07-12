require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test

# def setup
#   @game = Game.new
#   @board = Board.new
#   @board.generate_cells
#   @cruiser = Ship.new("Cruiser", 3)
#   @submarine = Ship.new("Submarine", 2)
# end

  # def test_it_exists
  #   @game = Game.new
  #
  #   assert_instance_of Game, @game
  # end

  def test_turn
    @game = Game.new
    @board = @game.board

    @game.main_menu

    p @game.turn

    assert_equal "You already fired on this spot", @game.turn
  end

end
