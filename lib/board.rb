class Board

  def initialize
    @cells = {}
  end

  def cells #change this name
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
    letter = array.map do |cord|
     cord[0]
    end

    num = array.map do |cord|
      cord[1]
    end

    num = num.map(&:to_i)
    ord = letter.map(&:ord)

    (ship.length == 2 && array.length == 2 ||
    ship.length == 3 && array.length == 3) &&
    (((letter.uniq.size == 1 && (num.each_cons(2).all? { |x,y| y == x + 1})) ||
    (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1})))

    #rename x and y for each_cons to position 1 and position 2

    #need to add a @cell empty? boolean
  end

  def place(ship, array)
    if valid_placement?(ship, array)
      array.each do |cell|

for each element of array assign
it to @cells
maybe select method? 
  end
end #class
