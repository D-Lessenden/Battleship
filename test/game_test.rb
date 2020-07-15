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
    skip
    @game.stubs(:get_user_input).returns("P")

    assert_equal true, @game.main_menu
  end

  def test_cpu_place_cruiser
    refute nil, @game.cpu_place_cruiser
    refute nil, @game.cpu_place_sub
  #  binding.pry
    p @game.cpu_board.render
  end


  def test_game_over_p1_win
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @game.cpu_board.place(@cpu_sub, ["B1", "B2"])
    @game.cpu_board.place(@cpu_cruiser, ["A1", "A2", "A3"])
    @game.cpu_board.verify_and_fire("A1")
    @game.cpu_board.verify_and_fire("A2")
    @game.cpu_board.verify_and_fire("A3")
    @game.cpu_board.verify_and_fire("B1")
    @game.cpu_board.verify_and_fire("B2")
    assert_equal true, @cpu_sub.sunk?
    assert_equal true, @cpu_cruiser.sunk?
    assert_equal nil, @game.human_win?
  end

  def test_game_over_cpu_win
    @sub = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
    @game.board.place(@sub, ["B1", "B2"])
    @game.board.place(@cruiser, ["A1", "A2", "A3"])
    @game.board.verify_and_fire("A1")
    @game.board.verify_and_fire("A2")
    @game.board.verify_and_fire("A3")
    @game.board.verify_and_fire("B1")
    @game.board.verify_and_fire("B2")
    assert_equal true, @sub.sunk?
    assert_equal true, @cruiser.sunk?
    assert_equal nil, @game.cpu_win?
  end


  def test_turn_human_fire_miss
    skip #this passes but with it unskipped need to play a round
    @cpu_sub = Ship.new("Submarine", 2)
    @game.cpu_board.place(@cpu_sub, ["A1", "A2"])
    assert_equal "Your shot missed", @game.turn
  end

  def test_turn_human_fire_sink
    skip #this passes but with it unskipped need to play a round
    @cpu_sub = Ship.new("Submarine", 2)
    @game.cpu_board.place(@cpu_sub, ["A1", "A2"])
    @game.cpu_board.render(true)
    @game.cpu_board.verify_and_fire("A1")
    assert_equal "Sunk", @game.turn
  end

  def test_turn_human_fire_hit
    skip #this passes but with it unskipped need to play a round
    @cpu_sub = Ship.new("Submarine", 2)

    @game.cpu_board.place(@cpu_sub, ["A1", "A2"])
    @game.cpu_board.render
    assert_equal "Hit", @game.turn
  end



end #class
