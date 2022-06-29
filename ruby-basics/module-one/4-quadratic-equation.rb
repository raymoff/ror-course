# Квадратное уравнение

puts 'Введите значения построчно: '

# Массив для значений
nums = []

# Получаем значения и добавляем значения в массив
3.times do
  nums << gets.chomp.to_i
end

# Распределяем значения по переменным
a, b, c = nums

# Проверяем полученные значения на наличие нуля
if a == 0 || b == 0 || c == 0
  puts 'Все значения не должны равны нулю, введите значения еще раз.'
  exit
end

# Формула вычисления значение дискриминанта
discriminant = b**2 - 4 * a * c

# Корень дискриминанта

# Решаем уравнение
if discriminant > 0
  discriminant_root = Math.sqrt(discriminant)
  x1 = (-b + discriminant_root) / (2 * a)
  x2 = (-b - discriminant_root) / (2 * a)
  puts "Дискриминант: #{discriminant}. Два корня: #{x1} и #{x2}"
elsif discriminant == 0
  x = -b / (2 * a)
  puts "Дискриминант: #{discriminant}. Один корень: #{x}"
else
  puts 'Корни отсутсвуют.'
end
