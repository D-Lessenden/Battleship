require "pry"
class Game

  def initialize
    @board = Board.new
    @board.generate_cells
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @sub = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
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
    @board.render
    p "==============PLAYER BOARD=============="
    @board.render(true)
  end

  def turn
    # @board.place(@cruiser, ["A1", "A2", "A3"])
    game_board
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp.upcase!
    #shot = gets.chomp!.upcase
    # @board.check_user_input(shot) not working as method????
      until @board.valid_coordinate?(shot) == true
      puts "Those are invalid coordinates. Please try again."
      shot = gets.chomp!.upcase
      end
    @board.verify_and_fire(shot)
     #helper method to verify verify_and_fire -P
    #build helper method for computer fire -D
    #steal from cell.render for results of shots
    binding.pry
      if @board.cells[shot].empty? == false && (@board.cells[shot].misses == 1)
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

  #  @cpu_cruiser = Ship.new("Cruiser", 3)
    @board.place(@cpu_cruiser, coords)
    #@board.render(true) #take this out, using it for testing
  end

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

  #  @cpu_sub = Ship.new("Submarine", 2)
  #  binding.pry
    @board.place(@cpu_sub, coords)
    #@board.render(true) #take this out, using it for testing
  end

  def cpu_fire
  #  binding.pry
    valid_cells = @board.cells.select do |k, v|
      @board.valid_coordinate?(k)
    end

    cpu_fire = valid_cells[valid_cells.keys.sample]
    cpu = cpu_fire.coordinate

    @board.verify_and_fire(cpu)
    p cpu
  end




  def turn_result
    # print user results
    # print cpu results
  end


   def human_win
     (@cpu_sub.sunk? == true ) && (@cpu_cruiser.sunk? == true)
     p "You won!" #if call @cpu_sub.hit it takes away from health but not with    @board.cells["A1"].fire_upon
   #need to insert this at the end of every turn
   end

   def cpu_win
     (@sub.sunk? == true) && (@cruiser.sunk? == true)
     p "Computer win!"
   end



end#class
