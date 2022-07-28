# frozen_string_literal:true

# Инициализируем пустой хэш
vowels = {}

# Начала отсчета, где a = 1
counter = 1

# Блок each по всему алфавиту, и добавляем гласные буквы
('a'..'z').each do |letter|
  vowels[letter] = counter if %w[a e i o u].include?(letter)
  counter += 1
end

# Вывыдим в консоль
puts vowels
