class Cell
attr_reader :coordinate, :ship, :misses
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @misses = 0
  end

  # added :ship to attr_reader which negates need for ship method
  # def ship
  #   @ship
  # end

  def empty?
    @ship == nil
  end

  def place_ship(type)
    @ship = type
  end

  #removed unnecessary if statement, moved above fired_upon? for readability
  def fire_upon
    if empty?
      @misses += 1
    elsif @ship != nil
      @ship.hit
    end
  end

  def fired_upon?
    if @misses == 0
      false
    elsif @misses > 0
      true
    elsif @ship.health != @ship.length
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
