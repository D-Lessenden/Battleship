class Cell
attr_reader :coordinate
  def initialize(coordinate)
    @coordinate = coordinate
    @ship
  end

  def ship
    @ship
  end

  def empty?
    @ship == nil
  end

  def place_ship(type)
    @ship = type
  end

  def fired_upon?
      @ship.health != @ship.length
  end

  def fire_upon
    if @ship == nil
      procrastinate
    else
      @ship.hit
    end
  end

  def procrastinate
  end

  def render
    if fired_upon? == false
      p "."
    elsif fired_upon? == true && @ship.sunk? == true
      p "X"
    elsif fired_upon? == true && empty? == nil #nil and false
      p "M"
    elsif fired_upon? == true && empty? == false
      p "H"
    end

  end

end
