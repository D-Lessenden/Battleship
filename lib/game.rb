class Game
attr_reader :board, :cpu_board
  def initialize
    @board = Board.new
    @board.generate_cells
    @sub = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
    @cpu_board = Board.new
    @cpu_board.generate_cells
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
  end

  def game_play
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
    main_menu
    instructions
    turn
    return_to_main_menu
  end

  def get_user_input
    gets.chomp!.upcase
  end

  def main_menu
    @initial_input = get_user_input
    until (@initial_input == "P") || (@initial_input == "Q")
      puts "Invalid selection.\nEnter p to play. Enter q to quit"
      @initial_input = get_user_input
    end
    if @initial_input == "Q"
          puts "Bye Felicia"
          exit!
    elsif @initial_input == "P"
        puts "So it is decided, we battle the ships!"
        cpu_place_cruiser
        cpu_place_sub
      #  binding.pry
    end
  end


  def instructions
    puts "I have laid out my ships on the grid.\n
    You now need to lay out your two ships.\n
    The Cruiser is three units long and the Submarine is two units long."
    #sleep(?)
    puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
    puts "Enter the squares for the Sub (2 spaces):"
    user_input = get_user_input
    placement = []
    placement << user_input.split(" ")
    placement.flatten!
    until @board.valid_placement?(@sub, placement) == true
      puts "Those are invalid coordinates. Please try again."
      user_input = gets.chomp.upcase
      placement = []
      placement << user_input.split(" ")
      placement.flatten!
    end #end method
    @board.place(@sub, placement)

    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.upcase #method
    placement = []
    placement << user_input.split(" ")
    placement.flatten! #end method
      until @board.valid_placement?(@cruiser, placement) == true #method
        puts "Those are invalid coordinates. Please try again."
        user_input = gets.chomp.upcase
        placement = []
        placement << user_input.split(" ")
        placement.flatten!
      end #end method
    @board.place(@cruiser, placement)
    turn

  end

  def game_board
    p "=============COMPUTER BOARD============="
    @cpu_board.render
    p "==============PLAYER BOARD=============="
    @board.render(true)
  end


  def turn
    until human_win? == true || cpu_win? == true
      game_board
      puts "Enter the coordinate for your shot:"
      shot = gets.chomp!.upcase
      until (@cpu_board.valid_coordinate?(shot) == true) && (@cpu_board.cells[shot].fired_upon? == false)
          p "Those are invalid coordinates or you have already fired on that spot. Please try again."
          shot = gets.chomp!.upcase
      end

      @cpu_board.verify_and_fire(shot)
          if @cpu_board.cells[shot].empty? == true
            p "Your shot missed!"
          elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == true
             p "You sunk a ship!"
          elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == false
             p "You hit a ship!"
          end
          sleep(2)
        if (@cpu_sub.sunk? == false) || (@cpu_cruiser.sunk? == false)
          cpu_fire
        end
      sleep(2)

    end
  end #turn method

  def cpu_place_cruiser
    coord = @cpu_board.cells[@cpu_board.cells.keys.sample]

    num = coord.coordinate[1].to_i
    @cruiser_letter = coord.coordinate[0]
    coords = [coord.coordinate]

    if num <= 2
      coord2 = "#{@cruiser_letter+(num+1).to_s}"
      coord3 = "#{@cruiser_letter+(num+2).to_s}"
      coords << coord2
      coords << coord3
      coords.sort!
    elsif num >= 3
      coord2 = "#{@cruiser_letter+(num-1).to_s}"
      coord3 = "#{@cruiser_letter+(num-2).to_s}"
      coords << coord2
      coords << coord3
      coords.sort!
    end
    @cpu_board.place(@cpu_cruiser, coords)
  end #cpu cruiser placement

  def cpu_place_sub
    valid_sub_cells = @board.cells.select do |k, v|
      !k.include?(@cruiser_letter)
    end

    coord = valid_sub_cells[valid_sub_cells.keys.sample]
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
      else
        coord2 = "#{letter+(num+1).to_s}"
        coords << coord2
        coords.sort!
      end
    @cpu_board.place(@cpu_sub, coords)
  end #sub placer method

  def cpu_fire
    valid_cells = @board.cells.select do |k, v|
      @board.valid_and_no_shot(k)
    end

    cpu_fire = valid_cells[valid_cells.keys.sample]
    cpu = cpu_fire.coordinate
    @board.verify_and_fire(cpu)

    if @board.cells[cpu].empty? == true
      p "I missed!? Are you moving your ships?"
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == true
      p "Ha! I got you! One down. One to go."
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == false
      p "Ha! I got you!"
    end
  end

   def human_win?
     if (@cpu_sub.sunk? == true) && (@cpu_cruiser.sunk? == true)
      puts "You WINJKSDHF:SKDJFHSD:FJKHSDF:OSFH"
      return_to_main_menu
     end
   end

   def cpu_win?
     if (@sub.sunk? == true) && (@cruiser.sunk? == true)
       puts "I WIN:KHDF:SDIUHFS DOFHSDF"
      return_to_main_menu
      end
    end

   def return_to_main_menu
     game_play
   end

end#class
