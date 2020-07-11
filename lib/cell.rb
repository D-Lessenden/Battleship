class Cell
attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @misses = 0
    @hit = 0
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
       "."
    elsif fired_upon? == true && empty?
       "M"
    elsif fired_upon? == true && @ship.sunk? == true
       "X"
    elsif fired_upon? == true && @ship.sunk? == false
       "H"
    end
  end
end
