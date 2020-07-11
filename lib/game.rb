class Game

  def initialize
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
        @board.valid_placement?
        if true @board.valid_placement?
        elsif false
        end
          puts "Those are invalid coordinates. Please try again."

        puts "Enter the squares for the Sub (2 spaces):"
        @user_sub_placement = gets.chomp.upcase!
        if true @board.valid_placement?
        elsif false
          puts "Those are invalid coordinates. Please try again."
        end

        #ship_placements(method)
        @board.render(true)

      elsif @initial_input == "q"
        puts "Bye Felicia"
      elsif @initial_input != "p" || "q"
        puts "Enter p to play. Enter q to quit"
      end
  end




end
