require 'pry'
class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @board.generate_cells
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

  end

   def main_menu
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
    @initial_input = gets.chomp!.upcase
      if @initial_input == "P"
        instructions
        # puts "Enter the squares for the Sub (2 spaces):"
        # @user_sub_placement = gets.chomp.upcase!
        # if true @board.valid_placement?
        # elsif false
        #   puts "Those are invalid coordinates. Please try again."
        # end
        #
        # #ship_placements(method) should verify valid coordinate, transforms data to array, and places ship
        # @board.render(true)

      elsif @initial_input == "Q"
          puts "Bye Felicia"
      end
   end
  #

  def instructions
    puts "I have laid out my ships on the grid.\n
    You now need to lay out your two ships.\n
    The Cruiser is three units long and the Submarine is two units long."
    #sleep(?)
    puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
    puts "Enter the squares for the Sub (2 spaces):"
    user_input = gets.chomp.upcase
    placement = []
    placement << user_input.split(" ")
    placement.flatten!
    until @board.valid_placement?(@submarine, placement) == true
      puts "Those are invalid coordinates. Please try again."
      user_input = gets.chomp.upcase
      placement = []
      placement << user_input.split(" ")
      placement.flatten!
    end
    @board.place(@submarine, placement)

    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.upcase
    placement = []
    placement << user_input.split(" ")
    placement.flatten!
      until @board.valid_placement?(@cruiser, placement) == true
        puts "Those are invalid coordinates. Please try again."
        user_input = gets.chomp.upcase
        placement = []
        placement << user_input.split(" ")
        placement.flatten!
      end
    @board.place(@cruiser, placement)
    @board.render(true)
  end

  def game_board
    p "=============COMPUTER BOARD============="
    @board.render
    p "==============PLAYER BOARD=============="
    @board.render(true)
  end

  def turn
    # @board.place(@cruiser, ["A1", "A2", "A3"])
    game_board
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp!.upcase
    # @board.check_user_input(shot) not working as method????
      until @board.valid_coordinate?(shot) == true
      puts "Those are invalid coordinates. Please try again."
      shot = gets.chomp!.upcase
      end
    @board.verify_and_fire(shot)
    # build helper method for computer fire -D
      if @board.cells[shot].fired_shots_recieved > 1
        "You already fired on this spot"
      elsif @board.cells[shot].empty? == false && @board.cells[shot].fired_shots_recieved == 1
        "Hit"
      elsif @board.cells[shot].empty? == true
        "Miss"
      end
    #If cell already fired upon, user notified
  end




  # def game_over
  #   if user ships sunk
  #     puts "I won!"
  #   elsif cpu ships sunk
  #     puts "You won!"
  # end
end
