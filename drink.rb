class Drink
  attr_reader :name, :price

  def self.cola
    new(120, 'コーラ').to_info
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
  end
end
