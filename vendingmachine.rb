require './drink'

module ProcessingCola
  def case_cola
    @sales_money += @juice[:type1][:price]
    @slot_money -= @juice[:type1][:price]
    @juice[:type1][:stock] -= 1
    @purchased_juice.push(@juice[:type1])
    "残額#{@slot_money}円"
  end
  module_function :case_cola
end

module ProcessingRedbull
  def case_redbull
    @sales_money += @juice[:type2][:price]
    @slot_money -= @juice[:type2][:price]
    @juice[:type2][:stock] -= 1
    @purchased_juice.push(@juice[:type2])
    "残額#{@slot_money}円"
  end
  module_function :case_redbull
end

module ProcessingWatter
  def case_watter
    @sales_money += @juice[:type3][:price]
    @slot_money -= @juice[:type3][:price]
    @juice[:type3][:stock] -= 1
    @purchased_juice.push(@juice[:type3])
    "残額#{@slot_money}円"
  end
  module_function :case_watter
end

# ---------------------------------------

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  include ProcessingCola
  include ProcessingRedbull
  include ProcessingWatter

  def initialize
    @juice = {
      type1: Drink.cola,
      type2: Drink.redbull,
      type3: Drink.water
    }
    @slot_money = 0
    @sales_money = 0
    @purchased_juice = []
  end

  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  def current_slot_money
    @slot_money
  end

  def current_sales_money
    @sales_money
  end

  def return_money
    puts @slot_money
    @slot_money = 0
  end

  def storing_info
    @juice.each do |_serial, info|
      info.each do |key, value|
        puts "#{key}：#{value}"
      end
      puts '---------------'
    end
  end

  def cola_buy_check
    @slot_money >= @juice[:type1][:price] && (@juice[:type1][:stock]).positive? ? 'コーラを購入可能' : 'コーラを購入不可'
  end

  def juice_buy
    p '購入する飲み物の数字を入力して下さい'
    puts '１：コーラ'
    puts '２：レッドブル'
    puts '３：水'
    select_number = gets.to_i

    case select_number
    when 1
      if @juice[:type1][:price] <= @slot_money && (@juice[:type1][:stock]).positive?
        case_cola
      else
        '購入できません'
      end
    when 2
      if @juice[:type2][:price] <= @slot_money && (@juice[:type2][:stock]).positive?
        case_redbull
      else
        '購入できません'
      end
    when 3
      if @juice[:type3][:price] <= @slot_money && (@juice[:type3][:stock]).positive?
        case_watter
      else
        '購入できません'
      end
    else
      '選択されたジュースはありません'
    end
  end

  def available_purchase
    juice = @juice.clone
    juice.delete_if { |_serial, info|
      info[:stock].zero? || info[:price] > @slot_money
    }
    if juice.empty?
      puts '購入できません'
    else
      juice.each do |_serial, info|
        puts info[:name]
      end
    end
  end

  def purchase_information
    @purchased_juice
  end
end
