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
    @ship.hit
  end
end
