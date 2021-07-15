# --------------------------------
# ！！！実行するメソッド一覧！！！
# --------------------------------

# irbでファイル読み込み
# require '/Users/yuyaya/desktop/work/vendingmachine_class.rb'

# インスタンス化
# vm = VendingMachine.new

# お金投入
# vm.slot_money (100)

# 現在の投入金額
# vm.current_slot_money

# 現在の売り上げ金額確認(STEP3-4)
# vm.current_sales_money

# お金返却
# vm.return_money

# 格納されているジュースの情報(STEP2)
# vm.stock_info

# 投入金額と在庫の点で、コーラが購入できるか(STEP3-1)
# vm.cola_buy_check

# ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす(STEP3-2)
# 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない(STEP3-3)
# 払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する(STEP3-5) 処理はここで結果はvm.return_moneyで出ます
# ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、釣り銭（投入金額とジュース値段の差分）を出力する(STEP5)
# vm.juice_buy

# 投入金額、在庫の点で購入可能なジュースのリスト
# vm.available_purchase_juice

# Drinkクラスをrequire
require './drink'

# 自動販売機クラスです
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
      type1: { name: 'コーラ', price: 120, stock: 5 },
      type2: { name: 'レッドブル', price: 200, stock: 5 },
      type3: { name: '水', price: 100, stock: 5 }
    }
    @slot_money = 0
    @sales_money = 0
    @purchased_juice = []
  end

  # 引数が投入できる金額として正しいか判断して投入する
  def slot_money(money)
    return false unless MONEY.include?(money)

    @slot_money += money
  end

  # 現在の投入金額
  def current_slot_money
    @slot_money
  end

  # STEP3 現在の売り上げ金額確認
  def current_sales_money
    @sales_money
  end

  # お金返却
  def return_money
    puts @slot_money
    @slot_money = 0
  end

  # STEP2 格納されているジュースの情報
  def stock_info
    @juice.each do |_serial, info|
      info.each do |key, value|
        puts "#{key}：#{value}"
      end
      puts '---------------'
    end
  end

  # STEP3 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。
  def cola_buy_check
    @slot_money >= @juice[:type1][:price] && (@juice[:type1][:stock]).positive? ? 'コーラを購入可能' : 'コーラを購入不可'
  end

  # STEP3 ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
  # STEP5 ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、釣り銭（投入金額とジュース値段の差分）を出力する。
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

  # STEP4 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。
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

  # 購入されたジュースのデータ履歴
  def purchase_information
    @purchased_juice
  end

end
