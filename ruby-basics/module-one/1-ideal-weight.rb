# Формула расчета идеального веса в зависимости от роста пользователя
puts 'Добрый день! Введите ваше имя:'
user_name = gets.chomp.to_s
puts 'Введите ваш рост:'
user_height = gets.chomp.to_i

# Формула вычисления идеального веса
ideal_weight = (user_height - 110) * 1.15

# Проверка на отрицательное значение полученного числа
if ideal_weight.negative?
  puts "#{user_name}, ваш вес уже идеален!"
else
  puts "#{user_name}, ваш идеальный вес должен составлять #{ideal_weight} кг."
end
