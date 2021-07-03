require './monster.rb'
require './brave.rb'
require './games_controller.rb'

games_controller = GamesController.new
monster = Monster.new(name: "スライム", hp: 350, offense: 200, defense: 100)
brave = Brave.new(name:'テリー', hp:500, offense:150, defense:100)
games_controller.battle(brave: brave, monster: monster)



