require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test


  def test_it_exists
    game = Game.new
    binding.pry
    assert_instance_of Game, @game
  end

end
