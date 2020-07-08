require './lib/cell'

class Board

  def initialize
    @cells = {}
  end

  def cells

    @cells = {
    "A1" => @cell1 = Cell.new("A1"),
    "A2" => @cell2 = Cell.new("A2"),
    "A3" => @cell3 = Cell.new("A3"),
    "A4" => @cell4 = Cell.new("A4"),
    "B1" => @cell5 = Cell.new("B1"),
    "B2" => @cell6 = Cell.new("B2"),
    "B3" => @cell7 = Cell.new("B3"),
    "B4" => @cell8 = Cell.new("B4"),
    "C1" => @cell9 = Cell.new("C1"),
    "C2" => @cell10 = Cell.new("C2"),
    "C3" => @cell11 = Cell.new("C3"),
    "C4" => @cell12 = Cell.new("C4"),
    "D1" => @cell13 = Cell.new("D1"),
    "D2" => @cell14 = Cell.new("D2"),
    "D3" => @cell15 = Cell.new("D3"),
    "D4" => @cell16 = Cell.new("D4")
    }
  end

  def valid_coordinate?(cord)
    @cells.has_key?(cord)
  end

  #valid_placement(ship, [cords])
  #true if ship.length == 3


end
