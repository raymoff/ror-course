# frozen_string_literal: true

# Хэш с месяцами
months = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

# Вычисляем месяцы с количеством дней равным 30
months_with_30_days = months.select { |_month, days| days == 30 }

# Выводим результат в консоль
puts months_with_30_days
