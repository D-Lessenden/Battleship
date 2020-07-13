require "pry"
class Game
attr_reader :board
  def initialize
    @board = Board.new
    @board.generate_cells
    @sub = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  #  @cpu_board = Board.new
  #  @cpu_board.generate_cells
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
  end

  #def main_menu
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
    @board.render #need to print cpu board 
    p "==============PLAYER BOARD=============="
    @board.render(true)
  end

  def turn
  # @board.place(@cruiser, ["A1", "A2", "A3"])
  game_board
  #also need to print cpu board
  puts "Enter the coordinate for your shot:"
  shot = gets.chomp!.upcase
  #if valid_coord is satisfied and move onto fired_upon, cannot back track to valid coord
    until @board.valid_coordinate?(shot) == true
      p "Those are invalid coordinates. Please try again."
      shot = gets.chomp!.upcase
    end
    until @board.cells[shot].fired_upon? == false
      p "You already fired at that space."
      shot = gets.chomp!.upcase
    end
  @board.verify_and_fire(shot)
      if @board.cells[shot].empty? == true
        "Your shot missed"
      elsif @board.cells[shot].fired_upon? == true && @board.cells[shot].ship.sunk? == true
         "Sunk"
      elsif @board.cells[shot].fired_upon? == true && @board.cells[shot].ship.sunk? == false
         "Hit"
      end
  end #turn method


  def cpu_place_cruiser
    coord = @board.cells[@board.cells.keys.sample]

    num = coord.coordinate[1].to_i
    letter = coord.coordinate[0]
    coords = [coord.coordinate]

    if num <= 2
      coord2 = "#{letter+(num+1).to_s}"
      coord3 = "#{letter+(num+2).to_s}"
      coords << coord2
      coords << coord3
      coords.sort!
    elsif num >= 3
      coord2 = "#{letter+(num-1).to_s}"
      coord3 = "#{letter+(num-2).to_s}"
      coords << coord2
      coords << coord3
      coords.sort!
    end

    @board.place(@cpu_cruiser, coords)
  end #cpu cruiser placement

  def cpu_place_sub
    coord = @board.cells[@board.cells.keys.sample]

    num = coord.coordinate[1].to_i
    letter = coord.coordinate[0]
    coords = [coord.coordinate]

    if num == 4
      coord2 = "#{letter+(num-1).to_s}"
      coords << coord2
      coords.sort!
    elsif num == 1
      coord2 = "#{letter+(num+1).to_s}"
      coords << coord2
      coords.sort!
    end
  end #sub placer method

  def cpu_fire
    valid_cells = @board.cells.select do |k, v|
      @board.valid_and_no_shot(k)
    end

    cpu_fire = valid_cells[valid_cells.keys.sample]
    cpu = cpu_fire.coordinate
    @board.verify_and_fire(cpu)

    if @board.cells[cpu].empty? == true
      "Miss!? Are you moving your ships?"
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == true
      "One down. One to go."
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == false
      "Ha! I got you!"
    end
  end




  def turn_result
    # print user results
    # print cpu results
  end


   def human_win
     (@cpu_sub.sunk? == true ) && (@cpu_cruiser.sunk? == true)
     p "You won!"
   end

   def cpu_win
     (@sub.sunk? == true) && (@cruiser.sunk? == true)
     p "Computer win!"
   end



end#class
