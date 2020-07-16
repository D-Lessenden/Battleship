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
    get_user_sub_coordinates
    place_user_sub
    get_user_cruiser_coordinates
    place_user_cruiser
    legend
    cpu_place_cruiser
    cpu_place_sub
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
      p "Bye Felicia"
      exit!

    elsif @initial_input == "P"
        puts "So it is decided, we battle the ships!"
        true
    end
  end


  def get_user_sub_coordinates
    puts "I have laid out my ships on the grid.\n
    You now need to lay out your two ships.\n
    The Cruiser is three units long and the Submarine is two units long."
    puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
    puts "Enter the squares for the Sub (2 spaces):"

    user_input = get_user_input
    @user_sub_coordinate = []
    @user_sub_coordinate << user_input.split(" ")
    @user_sub_coordinate.flatten!
      until @board.valid_placement?(@sub, @user_sub_coordinate) == true
        puts "Those are invalid coordinates. Please try again."
        user_input = get_user_input
        @user_sub_coordinate = []
        @user_sub_coordinate << user_input.split(" ")
        @user_sub_coordinate.flatten!
      end
    true
  end

  def place_user_sub
    @board.place(@sub, @user_sub_coordinate)
  end

  def get_user_cruiser_coordinates
    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = get_user_input
    @user_cruiser_coordinate = []
    @user_cruiser_coordinate << user_input.split(" ")
    @user_cruiser_coordinate.flatten!
      until @board.valid_placement?(@cruiser, @user_cruiser_coordinate) == true
        puts "Those are invalid coordinates. Please try again."
        user_input = get_user_input
        @user_cruiser_coordinate = []
        @user_cruiser_coordinate << user_input.split(" ")
        @user_cruiser_coordinate.flatten!
      end
    true
  end

  def place_user_cruiser
    @board.place(@cruiser, @user_cruiser_coordinate)
  end

  def game_board
   p "=============ENEMY BOARD============="
   @cpu_board.render
   p "==============PLAYER BOARD=============="
   @board.render(true)
 end


  def turn
    until human_win? == true || cpu_win? == true
      game_board
      puts "Enter the coordinate for your shot:"
      shot = get_user_input

        until (@cpu_board.valid_coordinate?(shot) == true)
            p "Please enter a valid coordinate."
            shot = get_user_input
        end
        unless @cpu_board.cells[shot].fired_upon? == false
           puts "You already fired on this spot, check your board :)"
        else
          @cpu_board.verify_and_fire(shot)
          if @cpu_board.cells[shot].empty? == true
            p "Your shot on #{shot} missed! Told you that you would be seeing that 'M' a lot."
          elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == true
             p "Your shot on #{shot} sunk a ship! This is malarkey!"
          elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == false
             p "You hit a ship on #{shot}! You scoundrel!"
          end
        end
          sleep(2)
          if (@cpu_sub.sunk? == false) || (@cpu_cruiser.sunk? == false)
            cpu_fire
          end
          sleep(2)
    end
      return_to_main_menu
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
      p "I missed a shot on #{cpu}!? Are you moving your ships?"
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == true
      p "Ha! I got you! My shot on #{cpu} sunk a ship! Take that scallywag!!"
    elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == false
      p "Ha! I got you at #{cpu}! You ain't slick, you can't hide from me."
    end
  end

   def human_win?
     if (@cpu_sub.sunk? == true) && (@cpu_cruiser.sunk? == true)
      p "You WIN AAAARRGRGRGHRGRHRGH"
      return_to_main_menu
    end
   end

   def cpu_win?
     if (@sub.sunk? == true) && (@cruiser.sunk? == true)
       p "I WIN!! I AM A GOLDEN GOD!!"
      return_to_main_menu
      end
    end

   def return_to_main_menu
     game_play
   end

   def legend
    puts "Let's commence on this gentlemanly contest."
    sleep(1)
    puts "Remember, 'H' stands for Hit."
    sleep(2)
    puts "'X' means that the entire ship has sunk and is underwater."
    sleep(2)
    puts "'S' stands for where your ship is located."
    sleep(2)
    puts "'.' is an unexplored space."
    sleep(2)
    puts "And remember this one, 'M' stands for a Miss... I have a feeling you'll be seeing that one a lot."
    sleep(3)
  end

end#class
