require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class Runner
@game = Game.new
@game.main_menu
end

@game 
