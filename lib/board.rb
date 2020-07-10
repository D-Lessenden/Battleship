class Board
  attr_reader :cells #added attr_reader w/ :cells so that @board.cells responds as indicated in specs

  def initialize
    #cells = @cells
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
    letter = coordinates.map do |cord|
     cord[0]
    end

    num = coordinates.map do |cord|
      cord[1]
    end

    num = num.map(&:to_i)
    ord = letter.map(&:ord)


    (ship.length == 2 && coordinates.length == 2 || ship.length == 3 && coordinates.length == 3) &&
    (((letter.uniq.size == 1 && (num.each_cons(2).all? { |x,y| y == x + 1})) || (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1})))


    #need to add a @cell empty? boolean
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |cord|
        @cells[cord].place_ship(ship)
      end


    # if valid_placement?(ship, coordinates) && coordinates.length == 3
    #     cell_1 = @cells["#{coordinates[0]}"]
    #     cell_2 = @cells["#{coordinates[1]}"]
    #     cell_3 = @cells["#{coordinates[2]}"]
    # else valid_placement?(ship, coordinates) && coordinates.length == 2
    #     cell_1 = @cells["#{coordinates[0]}"]
    #     cell_2 = @cells["#{coordinates[1]}"]
    end
  end

  #overlapping ships
  #cell.empty?


#   def render
#     grid = [
#     "  1 2 3 4 ",
#     "A . . . . ",
#     "B . . . . ",
#     "C . . . . ",
#     "D . . . . "
#     ].join("\n")
#     puts grid
#
#
#
#
#     # board.render
#     # -> Player 1 coordinates to attack?:
#     # -> user types "a1"
#     # cell.fire_upon
#     # board.render
# #use valid coordinate?("A1")
# board.cells["A1"].fire_upon
#
#
#
#
#   end




end #class
