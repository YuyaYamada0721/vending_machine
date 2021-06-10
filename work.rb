# require '/Users/yuyaya/desktop/work/work.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  #STEP2 ジュースの格納
  #STEP4 ジュース3種類

  #投入金額の初期化
  #STEP3 売り上げ金額の初期化

  @@juice = {
    type1: { name: 'コーラ', price: 120, stock: 5 },
    type2: { name: 'レッドブル', price: 200, stock: 5 },
    type3: { name: '水', price: 100, stock: 5 }
  }
  
  def initialize
    @slot_money = 0
    @juice_sales = 0
  end

  #現在の投入金額
  def current_slot_money
    @slot_money
  end

  #引数が投入できる金額として正しいか判断
  #投入する
  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  #投入金額返却
  def return_money
    puts @slot_money - @juice_sales
    @slot_money = 0
  end

  #ステップ2 格納されているジュースの情報
  def juice_data
    puts "#{@@juice[:type1][:name]}があります。#{@@juice[:type1][:price]}円です。#{@@juice[:type1][:stock]}本あります。"
    puts "#{@@juice[:type2][:name]}があります。#{@@juice[:type2][:price]}円です。#{@@juice[:type2][:stock]}本あります。"
    puts "#{@@juice[:type3][:name]}があります。#{@@juice[:type3][:price]}円です。#{@@juice[:type3][:stock]}本あります。"
  end

  # ステップ3 投入金額と在庫の点で、コーラが購入できるか
  def check_buy_cola
    if current_slot_money >= @@juice[:type1][:price] && @@juice[:type1][:stock] > 0
      'コーラを購入できます'
    else
      'コーラを購入できません'
    end
  end

  # ステップ3 ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
  def buy_juice(name)
    if name == 'コーラ' && @@juice[:type1][:price] <= @slot_money && @@juice[:type1][:stock] > 0
      @juice_sales = @@juice[:type1][:price]
      @@juice[:type1][:stock] = @@juice[:type1][:stock] - 1
    elsif @@juice[:type1][:price] > current_slot_money || @@juice[:type1][:stock] == 0
      '何も行わない'
    else
      '不明'
    end
  end

  # ステップ3 現在の売り上げ金額確認
  def current_juice_sales
    @juice_sales += @juice_sales
  end

  # ステップ4 投入金額、在庫の点で購入可能なジュースのリスト
  def available_purchase_juice
    if current_slot_money >= 200 && @@juice[:type1][:stock] > 0 && @@juice[:type2][:stock] > 0 && @@juice[:type3][:stock] > 0
      "#{@@juice[:type1][:name]}と#{@@juice[:type2][:name]}と#{@@juice[:type3][:name]}が購入できます。"
    end
  end
end
