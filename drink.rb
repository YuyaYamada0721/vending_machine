class Drink
  attr_reader :name, :price

  def self.cola
    new(120, 'コーラ').to_info # self.new(price, name) = Drink.new(price, name) = new ここでのselfはたい焼きの型 + コーラ味
  end

  def self.redbull
    new(200, 'レッドブル').to_info
  end

  def self.water
    new(100, '水').to_info
  end

  def initialize(price, name)
    @name = name
    @price = price
  end

  def to_info
    { name: @name, price: @price, stock: 5 }
    # ここでの self は実体化したもの  たい焼き自身

    # メソッド自体はたい焼きを売る
    # 実体化した後に使える技
  end
end
