
#
# # @cells = {
# # "A1" => @cell1 = Cell.new("A1"),
# # "A2" => @cell2 = Cell.new("A2"),
# # "A3" => @cell3 = Cell.new("A3"),
# # "A4" => @cell4 = Cell.new("A4"),
# # "B1" => @cell5 = Cell.new("B1"),
# # "B2" => @cell6 = Cell.new("B2"),
# # "B3" => @cell7 = Cell.new("B3"),
# # "B4" => @cell8 = Cell.new("B4"),
# # "C1" => @cell9 = Cell.new("C1"),
# # "C2" => @cell10 = Cell.new("C2"),
# # "C3" => @cell11 = Cell.new("C3"),
# # "C4" => @cell12 = Cell.new("C4"),
# # "D1" => @cell13 = Cell.new("D1"),
# # "D2" => @cell14 = Cell.new("D2"),
# # "D3" => @cell15 = Cell.new("D3"),
# # "D4" => @cell16 = Cell.new("D4")
# # }
#
#
#
#
computer ship placement

player ship


a = {
A1: "Cell1",
A2: "Cell2",
A3: "Cell3",
A4: "Cell4",
A5: "Cell5",
B1: "Cell6",
B2: "Cell7",
B3: "Cell8",
B4: "Cell9",
B5: "Cell10"
}

[1] pry(main)> a = {
[1] pry(main)*   A1: "Cell1",
[1] pry(main)*   A2: "Cell2",
[1] pry(main)*   A3: "Cell3",
[1] pry(main)*   A4: "Cell4",
[1] pry(main)*   A5: "Cell5",
[1] pry(main)*   B1: "Cell6",
[1] pry(main)*   B2: "Cell7",
[1] pry(main)*   B3: "Cell8",
[1] pry(main)*   B4: "Cell9",
[1] pry(main)*   B5: "Cell10"
[1] pry(main)* }
=> {:A1=>"Cell1", :A2=>"Cell2", :A3=>"Cell3", :A4=>"Cell4", :A5=>"Cell5", :B1=>"Cell6", :B2=>"Cell7", :B3=>"Cell8", :B4=>"Cell9", :B5=>"Cell10"}
[2] pry(main)> cords = a[a.keys.sample]
=> "Cell8"
[3] pry(main)> cords = a[a.keys.sample]
=> "Cell3"

take variable cords, add length of ship in one direction, run it thru
valid_placement, then place.




board = [
"  1 2 3 4 ",
"A . . . . ",
"B . . . . ",
"C . . . . ",
"D . . . . "
].join("\n")
#puts board

# Renders an ASCII grid based on a 2D array
def drawgrid(args, boxlen=3)
  #Define box drawing characters
  side = '│'
  topbot = '─'
  tl = '┌'
  tr = '┐'
  bl = '└'
  br = '┘'
  lc = '├'
  rc = '┤'
  tc = '┬'
  bc = '┴'
  crs = '┼'
  ##############################
  draw = []
  args.each_with_index do |row, rowindex|
    # TOP OF ROW Upper borders
    row.each_with_index do |col, colindex|
      if rowindex == 0
        colindex == 0 ? start = tl : start = tc
        draw << start + (topbot*boxlen)
        colindex == row.length - 1 ? draw << tr : ""
      end
    end
    draw << "\n" if rowindex == 0

    # MIDDLE OF ROW: DATA
    row.each do |col|
      draw << side + col.to_s.center(boxlen)
    end
    draw << side + "\n"

    # END OF ROW
    row.each_with_index do |col, colindex|
      if colindex == 0
        rowindex == args.length - 1 ? draw << bl : draw << lc
        draw << (topbot*boxlen)
      else
        rowindex == args.length - 1 ? draw << bc : draw << crs
        draw << (topbot*boxlen)
      end
      endchar = rowindex == args.length - 1 ? br : rc

      #Overhang elimination if the next row is shorter
      if args[rowindex+1]
        if args[rowindex+1].length < args[rowindex].length
          endchar = br
        end
      end
      colindex == row.length - 1 ? draw << endchar : ""
    end
    draw << "\n"
  end


  draw.each do |char|
    print char
  end
  return true
end

array = [['',1,2,3,4], ['A','.','.', '.', '.'], ['B','.','.','.','.'], ['C','.','.','.','.'], ['D','.','.','.','.']]

drawgrid(array)
p array[1][1]
p array[1][1].gsub!('.', 'M')
drawgrid(array)




def turn
  until human_win == true || cpu_win == true
    game_board
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp!.upcase
      until @cpu_board.valid_coordinate?(shot) == true  #until loops be one method
        p "Those are invalid coordinates. Please try again."
        shot = gets.chomp!.upcase
      end
      until @cpu_board.cells[shot].fired_upon? == false
        p "You already fired at that space."
        shot = gets.chomp!.upcase
      end
    @cpu_board.verify_and_fire(shot)  #method 85 - 92
        if @cpu_board.cells[shot].empty? == true
          p "Your shot missed"
        elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == true
           p "Sunk"
        elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == false
           p "Hit"
        end
        sleep(2)
      cpu_fire
    sleep(2)

        human_win #do until loops and human_win/cpu_win
        cpu_win
      end
   end_game
end #turn method



def instructions
  puts "I have laid out my ships on the grid.\n
  You now need to lay out your two ships.\n
  The Cruiser is three units long and the Submarine is two units long."
  #sleep(?)
  puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . ."
  puts "Enter the squares for the Sub (2 spaces):"
  user_input = gets.chomp.upcase #method
  placement = []
  placement << user_input.split(" ")
  placement.flatten!
  until @board.valid_placement?(@sub, placement) == true  #method
    puts "Those are invalid coordinates. Please try again."
    user_input = gets.chomp.upcase
    placement = []
    placement << user_input.split(" ")
    placement.flatten!
  end
  @board.place(@sub, placement)

  puts "Enter the squares for the Cruiser (3 spaces):"
  user_input = gets.chomp.upcase   #method test user input
  placement = []
  placement << user_input.split(" ")
  placement.flatten!
    until @board.valid_placement?(@cruiser, placement) == true #method test valid
      puts "Those are invalid coordinates. Please try again."
      user_input = gets.chomp.upcase
      placement = []
      placement << user_input.split(" ")
      placement.flatten!
    end
  @board.place(@cruiser, placement) #method spans from 48-59
  cpu_place_cruiser
  cpu_place_sub
  turn
end

def main_menu
  puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
  @initial_input = gets.chomp!.upcase
    if @initial_input == "P"
      instructions
    elsif @initial_input == "Q"
        puts "Bye Felicia"
    end
 end




 _______
 after all changes with phil
 require "pry"
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
      cpu_place_cruiser
      cpu_place_sub
      turn

    end

   def game_board
     p "=============COMPUTER BOARD=============" #change to enemy board
     @cpu_board.render
     p "==============PLAYER BOARD=============="
     @board.render(true)
   end

   def turn
     until human_win? == true || cpu_win? == true
       game_board
       input_for_human_fire
       # puts "Enter the coordinate for your shot:"
       # shot = gets.chomp!.upcase
       #   until @cpu_board.valid_coordinate?(shot) == true
       #     p "Those are invalid coordinates. Please try again."
       #     shot = gets.chomp!.upcase
       #   end
       #   until @cpu_board.cells[shot].fired_upon? == false
       #     p "You already fired at that space. Please try again."
       #     shot = gets.chomp!.upcase
       #   end
       @cpu_board.verify_and_fire(shot)
           if @cpu_board.cells[shot].empty? == true
             p "Your shot missed!"
           elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == true
              p "You sunk a ship!"
           elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == false
              p "You hit a ship!"
           end
           sleep(2)
         cpu_fire
       sleep(2)

     end
   end #turn method

   def input_for_human_fire
     puts "Enter the coordinate for your shot:"
     shot = gets.chomp!.upcase
     until (@cpu_board.valid_coordinate?(shot) == true) && (@cpu_board.cells[shot].fired_upon? == false)
       if @cpu_board.valid_coordinate?(shot) == false
         puts "Those are invalid coordinates. Please try again."
         shot = gets.chomp!.upcase
       elsif @cpu_board.cells[shot].fired_upon? == true
         puts "You already fired at that space. Please try again."
         shot = gets.chomp!.upcase
       end
     end
   end

   def cpu_place_cruiser
     coord = @cpu_board.cells[@cpu_board.cells.keys.sample]

     num = coord.coordinate[1].to_i
     @cruisr_letter = coord.coordinate[0]
     coords = [coord.coordinate]

     if num <= 2
       coord2 = "#{@cruisr_letter+(num+1).to_s}"
       coord3 = "#{@cruisr_letter+(num+2).to_s}"
       coords << coord2
       coords << coord3
       coords.sort!
     elsif num >= 3
       coord2 = "#{@cruisr_letter+(num-1).to_s}"
       coord3 = "#{@cruisr_letter+(num-2).to_s}"
       coords << coord2
       coords << coord3
       coords.sort!
     end
     @cpu_board.place(@cpu_cruiser, coords)
   end #cpu cruiser placement

   def cpu_place_sub
       valid_cells = @board.cells.select do |k, v|
         k.exlcude?(@letters)
       end
       coord = valid_cells[valid_cells.keys.sample]

       num = coord.coordinate[1].to_i
       letter = coord.coordinate[0]
       coords = [coord.coordinate]

       #until @cpu_board.valid_placement?(@cpu_sub, coords)
         if num == 4
           coord2 = "#{letter+(num-1).to_s}"
           coords << coord2
           coords.sort!
         elsif num == 1
           coord2 = "#{letter+(num+1).to_s}"
           coords << coord2
           coords.sort!
         end
   #  end
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
       p "Miss!? Are you moving your ships?"
     elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == true
       p "One down. One to go."
     elsif @board.cells[cpu].fired_upon? == true && @board.cells[cpu].ship.sunk? == false
       p "Ha! I got you!"
     end
   end

    def human_win
     if (@cpu_sub.sunk? == true) && (@cpu_cruiser.sunk? == true)
        puts "You won! You scallywag! You've ended meeeeeee!!!"
        exit! #go back to main menu instead (start_game)
      end
    end

    def cpu_win
      if (@sub.sunk? == true) && (@cruiser.sunk? == true)
        puts "Computer win!"
        exit! #go back to main menus instead
      end
    end


 end#class


 def turn
   until human_win? == true || cpu_win? == true
     game_board
     puts "Enter the coordinate for your shot:"
     shot = gets.chomp!.upcase
       until (@cpu_board.valid_coordinate?(shot) == true)
           p "Please enter a valid coordinate."
           shot = gets.chomp!.upcase
       end
       unless @cpu_board.cells[shot].fired_upon? == false
         puts "You already fired on this spot, check your board :)"
       else
         @cpu_board.verify_and_fire(shot)
          #if fired_upon? == true inform that they already shot there
         if @cpu_board.cells[shot].empty? == true
           p "Your shot on #{shot} missed!"
         elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == true
            p "Your shot on #{shot} sunk a ship!"
         elsif @cpu_board.cells[shot].fired_upon? == true && @cpu_board.cells[shot].ship.sunk? == false
            p "You hit a ship on #{shot}!"
         end
       end
         sleep(2)
       cpu_fire
     sleep(2)
   end
     return_to_main_menu
 end #turn method
