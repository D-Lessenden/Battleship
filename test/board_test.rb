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
    @board.generate_cells
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

  end

   def test_valid_placement
     @board.generate_cells
     submarine = Ship.new("Submarine", 2)
     cruiser = Ship.new("Cruiser", 3)
    # binding.pry

     assert_equal false, @board.valid_placement?(submarine, ["D3", "D3"])
     assert_equal true, @board.valid_placement?(submarine, ["B2", "B3"])
     assert_equal true, @board.valid_placement?(cruiser, ["A2", "A3", "A4"])
     assert_equal false, @board.valid_placement?(submarine, ["D2", "D3", "D4"])
     refute @board.valid_placement?(submarine, ["D2", "D3", "D4"]) #expected true not to be truthy
     assert_equal false, @board.valid_placement?(cruiser, ["A3", "A4"])
     assert_equal true, @board.valid_placement?(cruiser, ["A2", "A3", "A4"])
     assert_equal true, @board.valid_placement?(submarine, ["D2", "D3"])
     assert_equal false, @board.valid_placement?(submarine, ["D1", "D4"])
     assert_equal true, @board.valid_placement?(cruiser, ["A1", "B1", "C1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "B1", "D1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
     assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
     assert_equal false, @board.valid_placement?(submarine, ["C1", "B1"])
     assert_equal false, @board.valid_placement?(submarine, ["A1", "B2"])
     assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
   end



   def test_consecutive
     #used this originally to test diagonal and consecutive
     skip
     @board.generate_cells
     submarine = Ship.new("Submarine", 2)
     cruiser = Ship.new("Cruiser", 3)

     assert_equal true, @board.consecutive(cruiser, ["A2", "A3", "A4"])
     assert_equal true, @board.consecutive(submarine, ["D2", "D3"])
     assert_equal false, @board.consecutive(submarine, ["D1", "D4"])
     assert_equal true, @board.consecutive(cruiser, ["A1", "B1", "C1"])
     assert_equal false, @board.consecutive(cruiser, ["A1", "B1", "D1"])
     assert_equal false, @board.consecutive(cruiser, ["A1", "A2", "A4"])
     assert_equal false, @board.consecutive(submarine, ["A1", "C1"])
     assert_equal false, @board.consecutive(cruiser, ["A3", "A2", "A1"])
     assert_equal false, @board.consecutive(submarine, ["C1", "B1"])
     assert_equal false, @board.consecutive(submarine, ["A1", "B2"])
     assert_equal false, @board.consecutive(submarine, ["C2", "D3"])
     assert_equal false, @board.consecutive(cruiser, ["A1", "B2", "C3"])
   end


   def test_it_can_place_ship
     cruiser = Ship.new("Cruiser", 3)
     @board.generate_cells
     @board.place(cruiser, ["A1", "A2", "A3"])
     cell_1 = @board.cells["A1"]
     cell_2 = @board.cells["A2"]
     cell_3 = @board.cells["A3"]
     cell_1.ship
     cell_2.ship
     cell_3.ship
     assert_equal true, cell_1.ship == cell_2.ship
   end

   def test_overlapping_ships?
     @board.generate_cells
     cruiser = Ship.new("Cruiser", 3)
     @board.place(cruiser, ["A1", "A2", "A3"])
     submarine = Ship.new("Submarine", 2)
     assert_equal false, @board.valid_placement?(submarine, ["A1", "B1"])
     assert_equal true, @board.valid_placement?(submarine, ["D3", "D4"])
   end

   def test_render
     @board.generate_cells
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.place(cruiser, ["A1", "A2", "A3"])
     @board.place(submarine, ["D3", "D4"])
     p1 = "A4"
    #binding.pry

     @board.render
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     @board.render

     p1 = "A3"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     @board.render
     #
     p1 = "A2"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     #binding.pry
     @board.render

     p1 = "A1"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     #binding.pry
     @board.render



     #place some ships for testing in pry
     #@board.place(cruiser, ["A1", "A2", "A3"])

     #faulty logic, Prints M for every cell that doesn't have a ship
        #need to edit the cell.render method
     #When ship is Hit once, every cell that the ship is in changes from . to H
     #need to print on one line
   end


end
