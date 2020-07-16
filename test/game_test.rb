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
    # Cannot figure out how to test invalid selection becuase can't get out of loop
    # @game.stubs(:get_user_input).returns("A")
    # assert_equal true, @game.main_menu

    #Cannot figure out how to test exit because exit! always exits the test
    # @game.stubs(:get_user_input).returns("Q")
    # assert_equal true, @game.main_menu

    @game.stubs(:get_user_input).returns("P")
    assert_equal true, @game.main_menu

  end


  def test_it_can_get_coordinates_for_user_sub
    @game.stubs(:get_user_input).returns("A1 A2")

    assert_equal true, @game.get_user_sub_coordinates
  end


  def test_it_can_place_user_sub
    @game.stubs(:get_user_input).returns("A1 A2")

    @game.get_user_sub_coordinates
    @game.place_user_sub

    assert_equal "Submarine", @game.board.cells["A1"].ship.name
  end


  def test_it_can_get_coordinates_for_user_cruiser
    @game.stubs(:get_user_input).returns("A1 A2 A3")

    assert_equal true, @game.get_user_cruiser_coordinates
  end


  def test_it_can_place_user_cruiser
    @game.stubs(:get_user_input).returns("A1 A2 A3")

    @game.get_user_cruiser_coordinates
    @game.place_user_cruiser

    assert_equal "Cruiser", @game.board.cells["A1"].ship.name
  end


  def test_cpu_place_cruiser
    refute nil, @game.cpu_place_cruiser
    refute nil, @game.cpu_place_sub
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
      skip#this passes but with it unskipped need to play a round, shoot at any space but A1 or A2
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

  def test_cpu_fire_miss
    #skip
    @game.board.verify_and_fire("A1")

    @game.board.verify_and_fire("A2")
    @game.board.verify_and_fire("A3")
    @game.board.verify_and_fire("A4")
    @game.board.verify_and_fire("B1")
    @game.board.verify_and_fire("B2")
    @game.board.verify_and_fire("B3")
    @game.board.verify_and_fire("B4")
    @game.board.verify_and_fire("C1")
    @game.board.verify_and_fire("C2")
    @game.board.verify_and_fire("C3")
    @game.board.verify_and_fire("C4")
    @game.board.verify_and_fire("D1")
    @game.board.verify_and_fire("D2")
    @game.board.verify_and_fire("D3")
    assert_equal "I missed a shot on D4!? Are you moving your ships?", @game.cpu_fire
  end

  def test_cpu_fire_hit
    skip
    @game.stubs(:get_user_input).returns("D1 D2")
    @game.get_user_sub_coordinates
    @game.place_user_sub
    @game.board.verify_and_fire("A1")
    @game.board.verify_and_fire("A2")
    @game.board.verify_and_fire("A3")
    @game.board.verify_and_fire("A4")
    @game.board.verify_and_fire("B1")
    @game.board.verify_and_fire("B2")
    @game.board.verify_and_fire("B3")
    @game.board.verify_and_fire("B4")
    @game.board.verify_and_fire("C1")
    @game.board.verify_and_fire("C2")
    @game.board.verify_and_fire("C3")
    @game.board.verify_and_fire("C4")
    @game.board.verify_and_fire("D3")
    @game.board.verify_and_fire("D4")
    assert_equal "Ha! I got you! Hit on D2!",  @game.cpu_fire
    #50/50 chance of this throwing error as there are 2 possible places left and shooting both sinks the ship
  end

  def test_cpu_fire_sunk
    @game.stubs(:get_user_input).returns("D1 D2")
    @game.get_user_sub_coordinates
    @game.place_user_sub
    @game.board.verify_and_fire("A1")

    @game.board.verify_and_fire("A2")
    @game.board.verify_and_fire("A3")
    @game.board.verify_and_fire("A4")
    @game.board.verify_and_fire("B1")
    @game.board.verify_and_fire("B2")
    @game.board.verify_and_fire("B3")
    @game.board.verify_and_fire("B4")
    @game.board.verify_and_fire("C1")
    @game.board.verify_and_fire("C2")
    @game.board.verify_and_fire("C3")
    @game.board.verify_and_fire("C4")
    @game.board.verify_and_fire("D1")
    @game.board.verify_and_fire("D3")
    @game.board.verify_and_fire("D4")
    assert_equal "Ha! I got you! My shot on D2 sunk a ship! One down. One to go.", @game.cpu_fire
  end

end
