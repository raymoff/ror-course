# frozen_string_literal: true

# Пустой хэш корзины
user_cart = {}

# Полная стоимость всех товаров
total_amount = 0

# Запускаем цикл заполняя корзину
loop do
  puts 'Введите наименование товара: '
  product_name = gets.chomp.downcase
  break if product_name == 'стоп'.downcase

  puts 'Введите цену за 1 единицу товара: '
  product_price = gets.to_i
  puts 'Введите количество купленных товаров:'
  amount = gets.to_i
  user_cart[product_name] = { price: product_price, amount: amount }
end

# Вывод корзины и всех покупок в консоль
puts user_cart

# Cчитаем стоимость покупок, как по отдельности так и общую цену всех товаров
user_cart.each do |name, purchase|
  item_price = purchase[:price] * purchase[:amount]
  total_amount += item_price
  puts "#{name}, количество: #{purchase[:amount]}, стоимость: #{item_price}"
end

# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
puts "Общая всех стоимость товаров: #{total_amount}"
