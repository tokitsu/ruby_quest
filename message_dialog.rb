module MessageDialog
  # 攻撃時のメッセージ
  def attack_message(**params)
    attack_type = params[:attack_type]
    puts "#{@name}の攻撃"
    puts "必殺攻撃" if attack_type == "special_attack"
  end

  # ダメージを受けた時のメッセージ
  def damage_message(**params)
    target = params[:target]
    damage = params[:damage]
    puts "#{target.name}は#{damage}のダメージを受けた"
    puts "#{target.name}の残りHPは#{target.hp}だ"
  end

  # バトルが終了した時のメッセージ
  def end_message(result)
    if result[:brave_win_flag]
      puts <<~EOS

      勇者は勝った
      #{result[:exp]}の経験値と#{result[:gold]}のゴールドを手に入れた

      EOS
    else
      puts <<~EOS

      勇者はまけた
      目の前が真っ暗になった

      EOS
    end
  end

  def transform_message(**params)
    @name = params[:origin_name]
    transform = params[:transform_name]
    puts "#{@name}が....."
    puts "#{transform}に変身した！！"

  end
end
