#require './lib/cell'

class Board

  def initialize
    @cells = {}
  end

  def cells
    letters = ["A", "B", "C", "D"]
    numbers = [1, 2, 3, 4]
    @cells = {}

    letters.each do |letter|
      numbers.each do |number|
        @cells["#{letter}"+"#{number}"] = (@cell = Cell.new("#{letter}"+"#{number}"))
      end
    end
  end

  def valid_coordinate?(cord)
    @cells.has_key?(cord)
  end

  #valid_placement(ship, [cords])
  #true if ship.length == 3
end
