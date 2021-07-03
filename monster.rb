require './character'

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

    # puts "#{@name}の攻撃"
    attack_message
    # puts "#{brave.name}は#{damage}のダメージを受けた"
    damage_message(target: brave, damage: damage)
      # puts "#{brave.name}の残りHPは#{brave.hp}だ"
      # puts "#{brave.name}の残りHPは0になった。"
  end

  def jadge_hald_hp
    if @hp < @half_hp
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
    
    if under_half_hp == "special"
      transform
    end
    damage = @offense - brave.defense
  end

  def critical_attack
    @offense * POWERUP_RATE
  end

  def transform
    transform_name = "ドラゴン"
    # puts "#{@name}が....."
    # puts "#{@name}に変身した！！"
    transform_message(origin_name: @name, transform_name: transform_name)

    @offense *= POWERUP_RATE
    @name = transform_name
  end
end
