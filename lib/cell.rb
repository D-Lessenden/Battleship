
class Cell
attr_reader :coordinate, :ship, :misses
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @misses = 0
    @hit = 0
  end

  def empty?
    @ship == nil
  end

  def place_ship(type)
    @ship = type
  end

  def fire_upon
    if empty?
      @misses += 1
    elsif @ship != nil
      @ship.hit
      @hit += 1
    end
  end

  def fired_upon?
    if !empty? && (@hit > 0)
      true
    elsif @misses == 0
      false
    elsif @misses > 0
      true
    end
  end


  def render
    if fired_upon? == false
      p "."
    elsif fired_upon? == true && empty?
      p "M"
    elsif fired_upon? == true && @ship.sunk? == true
      p "X"
    elsif fired_upon? == true && @ship.sunk? == false
      p "H"
    end
  end
end
