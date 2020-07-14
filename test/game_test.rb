require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'mocha/minitest'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists

    assert_instance_of Game, @game
  end

  def test_main_menu
    @game.stubs(:get_user_input).returns("p")

    assert_equal [], @game.main_menu
  end

end
