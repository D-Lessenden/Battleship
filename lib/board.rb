class Board
  attr_reader :cells #added attr_reader w/ :cells so that @board.cells responds as indicated in specs

  def initialize
    cells = @cells
    @cells = {}
  end

  def generate_cells #renamed as per Tim to be accurate to action performed and avoid confusion
    letters = ["A", "B", "C", "D"]
    numbers = [1, 2, 3, 4]

    letters.each do |letter| #changed to .map so that method returns the grid
      numbers.each do |number|
        @cells["#{letter}"+"#{number}"] =
        (@cell = Cell.new("#{letter}"+"#{number}"))
      end #numbers
    end #letters
    @cells
  end #generate_cells

  def valid_coordinate?(cord)
    @cells.has_key?(cord)
  end


  def valid_placement?(ship, coordinates)
    coordinate_letter = coordinates.map { |coord| coord[0] }
    coordinate_number = coordinates.map { |coord| coord[1] }

    ord = coordinate_letter.map(&:ord)
    num = coordinate_number.map(&:to_i)

    (ship.length == 2 && coordinates.length == 2 ||
    ship.length == 3 && coordinates.length == 3) &&
    (((coordinate_letter.uniq.size == 1 &&
    (num.each_cons(2).all? { |x,y| y == x + 1})) ||
    (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1})))
    #need to add a @cell empty? boolean
  end

  # def place(ship, coordinates)
  #   count = 0
  #   coordinates.length 3.times do |assignment|
  #     count += 1
  # end
end #class
