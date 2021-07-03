require './character'

class Brave < Character

  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    attack_type = decision_attack_type

    damage = calculate_damage(target: monster, attack_type: attack_type)

    cause_damage(target: monster, damage: damage)

    # puts "#{@name}の攻撃"
    attack_message(attack_type: attack_type)
    # puts "#{monster.name}は#{damage}のダメージを受けた"
    damage_message(target: monster, damage: damage)
      # puts "#{monster.name}の残りHPは#{monster.hp}だ"

      # puts "#{monster.name}の残りHPは0になった。"
  end

  private

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end

  def decision_attack_type
    attack_num = rand(4)

    if attack_num == 0
      "special_attack"
    else
      "normal_attack"
    end
  end

  def calculate_damage(**params)
    monster = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      # puts "必殺攻撃"
      damage = calculate_special_attack  - monster.defense
    else
      # puts "通常攻撃"
      damage = @offense - monster.defense
    end
  end

  def cause_damage(**params)
    monster = params[:target]
    damage = params[:damage]

    monster.hp -= damage
  end
end
