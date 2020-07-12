class Game

  def initialize
    @board = Board.new
    @board.generate_cells
  end

  def main_menu
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
    @initial_input = gets.chomp!
      if @initial_input == "p"
        puts "I have laid out my ships on the grid.\n
        You now need to lay out your two ships.\n
        The Cruiser is three units long and the Submarine is two units long."
        #sleep(?)
        puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
        puts "Enter the squares for the Cruiser (3 spaces):"
        @user_cruiser_placement = gets.chomp.upcase!
        @board.place(cruiser, @user_cruiser_placement)

          puts "Those are invalid coordinates. Please try again."
          puts "Enter the squares for the Sub (2 spaces):"
        @user_sub_placement = gets.chomp.upcase!
        if true @board.valid_placement?
        elsif false
          puts "Those are invalid coordinates. Please try again."
        end

        #ship_placements(method) should verify valid coordinate, transforms data to array, and places ship
        @board.render(true)

      elsif @initial_input == "q"
        puts "Bye Felicia"
      elsif @initial_input != "p" || "q"
        puts "Enter p to play. Enter q to quit"
      end
  end

  def game_board
    p "=============COMPUTER BOARD============="
    @board.render
    p "==============PLAYER BOARD=============="
    @board.render(true)
  end

  def turn
    game_board
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp.upcase!
    @board.verify_and_fire(shot)
     #helper method to verify verify_and_fire -P
    #build helper method for computer fire -D
    #steal from cell.render for results of shots
    #If cell already fired upon, user notified
  end

  def game_over
    if user ships sunk
      puts "I won!"
    elsif cpu ships sunk
      puts "You won!"
  end

end
