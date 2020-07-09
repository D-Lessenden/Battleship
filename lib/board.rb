#require './lib/cell'

class Board

  def initialize
    @cells = {}
  end

  def cells
    letters = ["A", "B", "C", "D"]
    numbers = [1, 2, 3, 4]

    letters.each do |letter|
      numbers.each do |number|
        @cells["#{letter}"+"#{number}"] = (@cell = Cell.new("#{letter}"+"#{number}"))
      end
    end
  end

  def valid_coordinate?(cord)
    @cells.has_key?(cord)
  end

  def valid_placement?(ship, array)
    if ship.length == 2 && array.length == 2
      true
    elsif
      ship.length == 3 && array.length == 3
      true
    else
      false
    end
  end

def consecutive(ship, array)
  b = []
  array.each do |cord|
    b << cord[0]
  end
  p b
end
end #class
 
# if array[0] == A || array[0] == B ||  array[0] == C || array[0] == D #horizontal
#   &&
# if array[1]
#
#
# range << cord[1]
# 2..4.to_a
#
#    && array[1] ==

#if all are A and

#if A are all A true
#if all
