
class Cell
attr_reader :coordinate, :ship, :fired_at
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @fired_shots_recieved = 0
  end

  def empty?
    @ship == nil
  end

  def place_ship(type)
    @ship = type
  end

  def fire_upon
    if empty?
      @fired_shots_recieved += 1
    elsif @ship != nil
      @ship.hit
      @fired_shots_recieved += 1
    end
  end

  def fired_upon?
    if @fired_shots_recieved == 0
      false
    elsif @fired_shots_recieved > 0
      true
    end
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
