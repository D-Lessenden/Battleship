
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
