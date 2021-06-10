# irbでファイル読み込み
# require '/Users/yuyaya/desktop/work/work.rb'

# インスタンス化
# vm = VendingMachine.new

# お金投入
# vm.slot_money (100)

# 現在の投入金額
# vm.current_slot_money

# お金返却
# vm.return_money

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  #投入金額の初期化
  #STEP2 ジュースの格納
  #STEP3 売り上げ金額の初期化
  #STEP4 ジュース3種類
  def initialize
    @slot_money = 0
    @sales_money = 0
    @juice = {
      type1: { name: 'コーラ', price: 120, stock: 5 },
      type2: { name: 'レッドブル', price: 200, stock: 5 },
      type3: { name: '水', price: 100, stock: 5 }
    }
  end

  #引数が投入できる金額として正しいか判断して投入する
  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  #現在の投入金額
  def current_slot_money
    @slot_money
  end

  #STEP3 現在の売り上げ金額確認
  def current_sales_money
    @sales_money
  end

  #お金返却
  def return_money
    puts @slot_money
    @slot_money = 0
  end

  #STEP2 格納されているジュースの情報
  def juice_data
    puts "#{@juice[:type1][:name]}があります。#{@juice[:type1][:price]}円です。#{@juice[:type1][:stock]}本あります。"
    puts "#{@juice[:type2][:name]}があります。#{@juice[:type2][:price]}円です。#{@juice[:type2][:stock]}本あります。"
    puts "#{@juice[:type3][:name]}があります。#{@juice[:type3][:price]}円です。#{@juice[:type3][:stock]}本あります。"
  end

  #STEP3 投入金額と在庫の点で、コーラが購入できるか
  def cola_buy_check
    if @slot_money >= @juice[:type1][:price] && (@juice[:type1][:stock]).positive?
      'コーラを購入できます'
    else
      'コーラを購入できません'
    end
  end

  #STEP3 ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
  #STEP5 ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、釣り銭（投入金額とジュース値段の差分）を出力する。
  def juice_buy(name)
    if name == 'コーラ' && @juice[:type1][:price] <= @slot_money && (@juice[:type1][:stock]).positive?
      @sales_money += @juice[:type1][:price]
      @slot_money -= @juice[:type1][:price]
      @juice[:type1][:stock] -= 1
      "残額#{@slot_money}円"
    elsif name == 'レッドブル' && @juice[:type2][:price] <= @slot_money && (@juice[:type2][:stock]).positive?
      @sales_money += @juice[:type2][:price]
      @slot_money -= @juice[:type2][:price]
      @juice[:type2][:stock] -= 1
      "残額#{@slot_money}円🕊🕊🕊"
    elsif name == '水' && @juice[:type3][:price] <= @slot_money && (@juice[:type3][:stock]).positive?
      @sales_money += @juice[:type3][:price]
      @slot_money -= @juice[:type3][:price]
      @juice[:type3][:stock] -= 1
      "残額#{@slot_money}円"
    else
      '何もしない,何もできない'
    end
  end

  #STEP4 投入金額、在庫の点で購入可能なジュースのリスト
  def available_purchase_juice
    if @slot_money >= 200 && (@juice[:type1][:stock]).positive? && (@juice[:type2][:stock]).positive? && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type1][:name]}●#{@juice[:type2][:name]}●#{@juice[:type3][:name]} 購入可能"
    elsif @slot_money >= 200 && (@juice[:type1][:stock]).zero? && (@juice[:type2][:stock]).positive? && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type2][:name]}●#{@juice[:type3][:name]} 購入可能"
    elsif @slot_money >= 200 && (@juice[:type1][:stock]).positive? && (@juice[:type2][:stock]).zero? && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type1][:name]}●#{@juice[:type3][:name]} 購入可能"
    elsif @slot_money >= 200 && (@juice[:type1][:stock]).positive? && (@juice[:type2][:stock]).positive? && (@juice[:type3][:stock]).zero?
      "●#{@juice[:type1][:name]}●#{@juice[:type2][:name]} 購入可能"
    elsif @slot_money >= 120 && (@juice[:type1][:stock]).positive? && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type1][:name]}●#{@juice[:type3][:name]} 購入可能"
    elsif @slot_money >= 120 && (@juice[:type1][:stock]).zero? && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type3][:name]} 購入可能"
    elsif @slot_money >= 120 && (@juice[:type1][:stock]).positive? && (@juice[:type3][:stock]).zero?
      "●#{@juice[:type1][:name]} 購入可能"
    elsif @slot_money >= 100 && (@juice[:type3][:stock]).positive?
      "●#{@juice[:type3][:name]} 購入可能"
    else
      '何もしない、何もできない'
    end
  end
end
