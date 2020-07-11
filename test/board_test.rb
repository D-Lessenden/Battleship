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

  def test_placement_is_not_valid_by_default
    @board.generate_cells
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_only_consecutive_cells_are_valid_placement
    @board.generate_cells
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_diagonal_placement_invalid
    @board.generate_cells
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
  end

   def test_valid_placement
     @board.generate_cells
     submarine = Ship.new("Submarine", 2)
     cruiser = Ship.new("Cruiser", 3)

     assert_equal false, @board.valid_placement?(submarine, ["D3", "D3"])
     assert_equal true, @board.valid_placement?(submarine, ["B2", "B3"])
     assert_equal true, @board.valid_placement?(cruiser, ["A2", "A3", "A4"])
     assert_equal true, @board.valid_placement?(cruiser, ["A2", "A3", "A4"])
     assert_equal true, @board.valid_placement?(submarine, ["D2", "D3"])
     assert_equal false, @board.valid_placement?(submarine, ["D1", "D4"])
     assert_equal true, @board.valid_placement?(cruiser, ["A1", "B1", "C1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "B1", "D1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
     assert_equal false, @board.valid_placement?(submarine, ["A1", "C1"])
     assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
     assert_equal false, @board.valid_placement?(submarine, ["A1", "B2"])
     assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
     assert_equal false, @board.valid_placement?(cruiser, ["A1", "A1", "A1"])
   end

   def test_cell_contains_no_ship_by_default
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.generate_cells

     assert_equal nil, @board.cells["A1"].ship
     assert_equal nil, @board.cells["B2"].ship
     assert_equal nil, @board.cells["C3"].ship
     assert_equal nil, @board.cells["D4"].ship
   end

   def test_it_can_place_ship
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.generate_cells

     @board.place(cruiser, ["A1", "A2", "A3"])
     @board.place(submarine, ["D3", "D4"])

     assert_equal "Cruiser", @board.cells["A1"].ship.name
     assert_equal "Submarine", @board.cells["D3"].ship.name
   end

   def test_ship_placed_on_consecutive_coordinates
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.generate_cells

     @board.place(cruiser, ["A1", "A2", "A3"])
     @board.place(submarine, ["D3", "D4"])

     assert_equal true, @board.cells["A1"].ship == @board.cells["A2"].ship
     assert_equal true, @board.cells["A2"].ship == @board.cells["A2"].ship
     assert_equal true, @board.cells["D3"].ship == @board.cells["D4"].ship
   end

   def test_placed_ships_do_not_overlap
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.generate_cells

     @board.place(cruiser, ["A1", "A2", "A3"])

     assert_equal false, @board.valid_placement?(submarine, ["A1", "B1"])
     assert_equal false, @board.valid_placement?(submarine, ["A2", "B2"])
     assert_equal false, @board.valid_placement?(submarine, ["A3", "B3"])
   end

   def test_render
     @board.generate_cells
     cruiser = Ship.new("Cruiser", 3)
     submarine = Ship.new("Submarine", 2)

     @board.place(cruiser, ["A1", "A2", "A3"])
     @board.place(submarine, ["D3", "D4"])
     @board.render(true)
     #@board.render

     @board.cells["D3"].fire_upon
     @board.render(true)

     @board.cells["C3"].fire_upon
     @board.render(true)

     @board.cells["D4"].fire_upon

     @board.render(true)
    # binding.pry
     @board.render

    p1 = "A4"
    #binding.pry

  #   @board.render
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     @board.render

     p1 = "A3"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     @board.render
     @board.render(true)

     #
     p1 = "A2"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     #binding.pry
     @board.render

     @board.cells["B4"].fire_upon
     @board.cells["C2"].fire_upon
     @board.cells["C1"].fire_upon
     @board.cells["D1"].fire_upon



     p1 = "A1"
     @board.valid_coordinate?(p1)
     @board.cells[p1].fire_upon
     #binding.pry
     @board.render
     @board.render(true)
   end
end
