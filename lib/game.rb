require 'pry'
class Game

  def initialize
    @board = Board.new
    @board.generate_cells
    # @cruiser = Ship.new("Cruiser", 3)
    # @submarine = Ship.new("Submarine", 2)
  end

  # def main_menu
  #   puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
  #   @initial_input = gets.chomp!
  #     if @initial_input == "p"
  #       puts "I have laid out my ships on the grid.\n
  #       You now need to lay out your two ships.\n
  #       The Cruiser is three units long and the Submarine is two units long."
  #       #sleep(?)
  #       puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
  #       puts "Enter the squares for the Cruiser (3 spaces):"
  #       @user_cruiser_placement = gets.chomp.upcase!
  #       @board.place(cruiser, @user_cruiser_placement)
  #
  #         puts "Those are invalid coordinates. Please try again."
  #         puts "Enter the squares for the Sub (2 spaces):"
  #       @user_sub_placement = gets.chomp.upcase!
  #       if true @board.valid_placement?
  #       elsif false
  #         puts "Those are invalid coordinates. Please try again."
  #       end
  #
  #       #ship_placements(method) should verify valid coordinate, transforms data to array, and places ship
  #       @board.render(true)
  #
  #     elsif @initial_input == "q"
  #       puts "Bye Felicia"
  #     elsif @initial_input != "p" || "q"
  #       puts "Enter p to play. Enter q to quit"
  #     end
  # end
  #
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
    #build helper method for computer fire -D
      if @board.cells[shot].empty? && (@board.cells[shot].misses == 1)
        "Your shot missed"
      elsif @board.cells[shot].empty? && (@board.cells[shot].misses > 1)
        "You already missed a shot on this cell, check your board :)"
      elsif @board.cells[shot].ship.sunk? == true && (@board.cells[shot].hit == 1)
        "You hit and sunk a ship!"
      elsif (@board.cells[shot].ship.sunk? == true) && (@board.cells[shot].hit > 1)
        "You hit a ship you already sunk, oh the humanity!"
      elsif (@board.cells[shot].hit == 1)
        "You hit a ship!"
      elsif (@board.cells[shot].hit > 1) && (@board.cells[shot].sunk? == false)
        "You already hit a ship here, check your board :)"
      end
    #If cell already fired upon, user notified
  end

  # def check_user_input(user_input)
  #   until @board.valid_coordinate?(shot) == true
  #     puts "Those are invalid coordinates. Please try again."
  #     shot = gets.chomp!.upcase
  #   end
  # end
  # Doesn't work as method



  # def game_over
  #   if user ships sunk
  #     puts "I won!"
  #   elsif cpu ships sunk
  #     puts "You won!"
  # end

end
