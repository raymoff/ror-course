# frozen_string_literal: true

# Инициализируем массив c первым числом последовательности Фибоначчи равный 0
fibonacci_arr = [0]

# Следующий элемент последовательности равный 1
next_element = 1

# Используем цикл while до 100 и добавляем каждое значение в массив
while next_element < 100
  fibonacci_arr << next_element
  next_element = fibonacci_arr[-2] + fibonacci_arr[-1]
end

# Выводим в консоль
puts fibonacci_arr
