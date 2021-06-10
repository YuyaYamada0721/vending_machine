# juices1 = {
#   juice1:[{ name: 'cola', price: 120 }],
#   juice2:[{ name: 'cola', price: 120 }]
# }

# p juices1[:juice1][0][:name]
# p juices1[:juice1][0][:price]

# juice = { type1: { name: 'cola', price: 120 } }
# p juice[:type1][:name]

 juice = [
    {type: { name: 'コーラ', price: 120, stock: 5 }},
    {type: { name: 'レッドブル', price: 200, stock: 5 }},
    {type: { name: '水', price: 100, stock: 5 }}
 ]

  p juice.dig(0, :type, :name)

  p juice.values_at
