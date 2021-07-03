require './message_dialog'

class GamesController

  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)

    @brave = params[:brave]
    @monster = params[:monster]

    loop do
      @brave.attack(@monster)
      break if battle_end?
      @monster.attack(@brave)
      break if battle_end?
    end

    buttle_judgment
  end
  private

  def battle_end?
    @brave.hp <= 0 || @monster.hp <= 0
  end

  def calculate_of_exp_and_gold
    if brave_win?
      brave_win_flag = true
      exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
      gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
    else
      brave_win_flag = false
      exp = 0
      gold = 0
    end

    {brave_win_flag: brave_win_flag, exp: exp, gold: gold}
  end

  def brave_win?
    @brave.hp > 0
  end

  def buttle_judgment
    result = calculate_of_exp_and_gold

    end_message(result)
    # puts "#{@brave.name}はたたかいに勝った"
    # puts "#{@exp}の経験値と#{@gold}ゴールドを獲得した"
    # puts "#{@brave.name}はたたかいに負けた"
    # puts "目の前が真っ暗になった"

  end

end
