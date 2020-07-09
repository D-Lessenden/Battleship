class Cell
attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
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
    if @ship != nil
      @ship.hit
    end
  end

  def fired_upon?
    if @ship == nil
      nil
    else
      @ship.health != @ship.length
    end
  end


  def render
    if fired_upon? == nil
      p "M"
    elsif fired_upon? == false
      p "."
    elsif fired_upon? == true && @ship.sunk? == true
      p "X"
    elsif fired_upon? == true && empty? == false
      p "H"
    end
  end
end
