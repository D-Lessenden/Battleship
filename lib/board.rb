
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
    (((letter.uniq.size == 1 && (num.each_cons(2).all? { |x,y| y == x + 1})) || (num.uniq.size == 1 && ord.each_cons(2).all? { |x,y| y == x + 1}))) &&
    (coordinates.all? {|cell| @cells[cell].empty?})
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |cord|
        @cells[cord].place_ship(ship)
      end
    end
  end



  def render(opt_arg = false)
   a_row = @cells.keys.select{ |keys| keys[0] == "A"}
   b_row = @cells.keys.select{ |keys| keys[0] == "B"}
   c_row = @cells.keys.select{ |keys| keys[0] == "C"}
   d_row = @cells.keys.select{ |keys| keys[0] == "D"}

   puts "    1 2 3 4"
    if opt_arg == false
     p "A| #{a_row.map { |key| @cells[key].render}.join(" ")} |"
     p "B| #{b_row.map { |key| @cells[key].render}.join(" ")} |"
     p "C| #{c_row.map { |key| @cells[key].render}.join(" ")} |"
     p "D| #{d_row.map { |key| @cells[key].render}.join(" ")} |"
   elsif opt_arg == true
     p "A| #{a_row.map { |key| @cells[key].render(true)}.join(" ")} |"
     p "B| #{b_row.map { |key| @cells[key].render(true)}.join(" ")} |"
     p "C| #{c_row.map { |key| @cells[key].render(true)}.join(" ")} |"
     p "D| #{d_row.map { |key| @cells[key].render(true)}.join(" ")} |"

   end

  end
end #class
