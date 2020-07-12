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
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_cpu_place_cruiser
    refute nil, @game.cpu_place_cruiser
    refute nil, @game.cpu_place_sub
  end
  # def test_cpu_place_cruiser2
  #   refute nil, @game.cpu_place_cruiser
  # end
  # def test_cpu_place_cruiser3
  #   refute nil, @game.cpu_place_cruiser
  # end
  # def test_cpu_place_cruiser4
  #   refute nil, @game.cpu_place_cruiser
  # end
  #
  # def test_cpu_place_sub
  #   refute nil, @game.cpu_place_sub
  # end
  # def test_cpu_place_sub2
  #   refute nil, @game.cpu_place_sub
  # end
  # def test_cpu_place_sub3
  #   refute nil, @game.cpu_place_sub
  # end
  # def test_cpu_place_sub4
  #   refute nil, @game.cpu_place_sub
  #end

  def test_cpu_fire
    assert_equal "M", @game.cpu_fire
  end

end
