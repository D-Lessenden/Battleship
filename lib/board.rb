class Board
  attr_reader :cells #added attr_reader w/ :cells so that @board.cells responds as indicated in specs

  def initialize
    cells = @cells
    @cells = {}
  end

  def generate_cells #renamed as per Tim to be accurate to action performed and avoid confusion
    letters = ["A", "B", "C", "D"]
    numbers = [1, 2, 3, 4]

    letters.each do |letter|
      numbers.each do |number|
        @cells["#{letter}"+"#{number}"] = (@cell = Cell.new("#{letter}"+"#{number}"))
      end #numbers
    end #letters
    @cells #added so that @board.generate_cells returns grid
  end #generate_cells

  def valid_coordinate?(cord)
    @cells.has_key?(cord)
  end


  def valid_placement?(ship, array)#change array to coordinates during refactor
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
        (((letter.uniq.size == 1 &&
          (num.each_cons(2).all? { |x,y| y == x + 1})) ||
            (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1})))
    #need to add a @cell empty? boolean
  end

  # def place(ship, array)
  #   count = 0
  #   array.length 3.times do |assignment|
  #     count += 1
  # end
end #class
