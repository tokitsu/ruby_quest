class Character
  attr_reader :offense, :defense
  attr_accessor :hp, :name

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end




class Brave < Character

  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    attack_type = decision_attack_type

    damage = calculate_damage(target: monster, attack_type: attack_type)

    cause_damage(target: monster, damage: damage)

    puts "#{@name}の攻撃"
    puts "#{monster.name}は#{damage}のダメージを受けた"
    if monster.hp > 0
      puts "#{monster.name}の残りHPは#{monster.hp}だ"
    else
      puts "#{monster.name}の残りHPは0になった。"
    end
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
      puts "必殺攻撃"
      damage = calculate_special_attack  - monster.defense
    else
      puts "通常攻撃"
      damage = @offense - monster.defense
    end
  end

  def cause_damage(**params)
    monster = params[:target]
    damage = params[:damage]

    monster.hp -= damage
  end
end


class Monster < Character

  POWERUP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
    @changed_doragon = false
    @half_hp = @hp * CALC_HALF_HP
  end

  def attack(brave)

    under_half_hp = jadge_hald_hp

    damage = calu_damage(target: brave, type: under_half_hp)

    cause_damage(target: brave, damage: damage)


    puts "#{@name}の攻撃"
    puts "#{brave.name}は#{damage}のダメージを受けた"
    if brave.hp > 0
      puts "#{brave.name}の残りHPは#{brave.hp}だ"
    else
      puts "#{brave.name}の残りHPは0になった。"
    end
  end

  def jadge_hald_hp
    if @hp < @half_hp && @changed_doragon == false
      "special"
    else
      "normal"
    end
  end

  def cause_damage(**params)
    brave = params[:target]
    damage = params[:damage]

    brave.hp -= damage
  end

  def calu_damage(**params)
    brave = params[:target]
    under_half_hp = params[:type]
    
    if under_half_hp == "spacial"
      transform
    end
    damage = @offense - brave.defense
  end

  def critical_attack
    @offense * POWERUP_RATE
  end

  def transform
    @changed_doragon == true
    puts "#{@name}が....."
    @name = "ドラゴン"
    puts "#{@name}に変身した！！"

    @offense *= POWERUP_RATE
  end
end

monster = Monster.new(name: "スライム", hp: 450, offense: 200, defense: 100)
brave = Brave.new(name:'テリー', hp:500, offense:150, defense:100)

loop do
  brave.attack(monster)
  if monster.hp <= 0
    exp = (monster.offense + monster.defense) * 2
    gold = (monster.offense + monster.defense) * 3
    puts "#{brave.name}はたたかいに勝った"
    puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
    break
  end

  monster.attack(brave)
  if brave.hp <= 0
    puts "#{brave.name}はたたかいに負けた"
    puts "目の前が真っ暗になった"
    break
  end
end
