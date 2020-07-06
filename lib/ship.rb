class Ship

  def initialize(name, length)
    @name = name
    @length = length

  end

  def health
    @health = @length
  end

  def sunk?
    @health == 0
  end

  def hit
    health - 1
  end

end
