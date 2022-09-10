# frozen_string_literal:true

# Получаем пользовательские данные ввода
puts 'Введите число: '
day = gets.to_i
puts 'Введите номер месяца: '
month = gets.to_i
puts 'Введите год: '
year = gets.to_i

# Проверяем високосный год
def february(year)
  if (year % 400).zero?
    29
  elsif (year % 4).zero? && !(year % 100).zero?
    29
  else
    28
  end
end

# Количество дней в месяцах
months = [31, february(year), 30, 31, 30, 31, 30, 31, 30, 31, 30]

# Выводим в консоль
puts months.first(month - 1).sum(day)
