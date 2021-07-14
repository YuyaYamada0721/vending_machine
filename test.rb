# juices1 = {
#   juice1:[{ name: 'cola', price: 120 }],
#   juice2:[{ name: 'cola', price: 120 }]
# }

# p juices1[:juice1][0][:name]
# p juices1[:juice1][0][:price]

# juice = { type1: { name: 'cola', price: 120 } }
# p juice[:type1][:name]

#  juice = [
#     {type: { name: 'コーラ', price: 120, stock: 5 }},
#     {type: { name: 'レッドブル', price: 200, stock: 5 }},
#     {type: { name: '水', price: 100, stock: 5 }}
#  ]

#   p juice.dig(0, :type, :name)

#   p juice.values_at

    @juice = {
      type1: { name: 'コーラ', price: 120, stock: 0 },
      type2: { name: 'レッドブル', price: 200, stock: 5 },
      type3: { name: '水', price: 100, stock: 1 }
    }

  # def stock_info
  #   @juice.each do |type, info|
  #     info.each do |key, value|
  #       puts "#{value}"
  #     end
  #     puts "---------------"
  #   end
  # end


  # def stock_info
  #   @juice.each do |j, k|
  #       # @data = k[:name]

  #   k.delete_if { |key, value|

  #   }

  #   p @data
  #   end
  #     puts "---------------"
  # end
@slot_money = 200

# def buy_info
#   @juice.delete_if { |k, v|
#     v[:stock] == 0
#     v[:price] <= @slot_money
#   }
#     p @juice
# end

# buy_info

  # def available_purchase_juice
  #   juice_info = @juice.new
  #   juice_info.delete_if { |k, v|
  #     v[:stock].zero?
  #     v[:price] > @slot_money
  #   }
  #   juice_info
  # end

    def available_purchase_juice
    juice = @juice.dup
    juice.delete_if { |serial, info|
      info[:stock].zero? || info[:price] > @slot_money
    }
    juice.each do |serial, info|
        puts info[:name]
      end
    end
    available_purchase_juice
