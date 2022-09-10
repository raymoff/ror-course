# Площадь треугольника
puts 'Введите длину основания треугольника:'
base_triangle = gets.chomp.to_i
puts 'Введите высоту треугольника:'
height_triangle = gets.chomp.to_i

# Формула вычисления площади треугольника, основание умножаем на высоту
triangle_square = 0.5 * base_triangle * height_triangle

# Выводим значение в консоль
puts "Площадь треугольника составляет - #{triangle_square}."
