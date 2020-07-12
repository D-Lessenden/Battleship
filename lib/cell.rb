
class Cell
  attr_reader :coordinate, :ship, :fired_shots_recieved

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @hit_result = nil
  end

  def empty?
    @ship.nil?
  end

  def place_ship(type)
    @ship = type
  end

  def fire_upon
    return :already_fired_upon if fired_upon?

    if empty?
      @hit_result = :miss
    else
      @ship.hit

      puts ''
      p @ship
      puts ''
      @hit_result = :hit
    end
  end

  def fired_upon?
    !@hit_result.nil?
  end

  def render(show_placements = false)
    if show_placements == false
      if fired_upon? == false
         "."
      elsif fired_upon? == true && empty?
         "M"
      elsif fired_upon? == true && @ship.sunk? == true
         "X"
      elsif fired_upon? == true && @ship.sunk? == false
         "H"
      end
    else show_placements == true
      if empty? == false && fired_upon? == false #place_shape = true
        "S"
      elsif fired_upon? == false
        "." #misses == 0
      elsif fired_upon? == true && empty?
        "M" #misses>0 || (not empty && hit > 0)
      elsif fired_upon? == true && @ship.sunk? == true
        "X" #misses = 0 && @health == 0
      elsif fired_upon? == true && @ship.sunk? == false
        "H" #misses == 0 && health > 0
      end#nested if
    end
  end#def render
end#class
