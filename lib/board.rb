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
      end #numbers
    end #letters
  end #cell

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
      letter = array.map do |cord|
       cord[0]
      end

      num = array.map do |cord|
        cord[1]
      end

      num = num.map(&:to_i)
      ord = letter.map(&:ord)

  (letter.uniq.size == 1 && (num.each_cons(2).all? { |x,y| y == x + 1})) ||
  (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1})
  end #consecutive

end #class
