require_relative 'stations'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railcar'
require_relative 'passenger_railcar'
require_relative 'cargo_railcar'

class StationControl
  def initialize
    @stations = []
    @trains = []
    @railcars = []
    @routes = []
  end

  # КОРНЕВОЕ МЕНЮ
  def show_menu
    puts 'Primary menu'
    choices_list('Stations', 'Trains', 'Railcars', 'Routes', true)
    input = gets.chomp

    loop do
      case input
      when '1'
        stations_menu
      when '2'
        trains_menu
      when '3'
        railcars_menu
      when '4'
        create_route_menu
      when 'Exit'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  protected

  # МЕНЮ СТАНЦИЙ
  def stations_menu
    stations_menu_intro
    choices_list(
      'Add station', 'List of stations', 'Go to trains control',
      'Back to primary menu', true
    )
    input = gets.chomp

    loop do
      case input
      when '1'
        create_station
      when '2'
        stations_list
        stations_menu
      when '3'
        trains_menu
      when '4'
        show_menu
      when 'Exit'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕНЮ ПОЕЗДОВ
  def trains_menu
    trains_menu_intro
    choices_list(
      'New train', 'Go to stations control', 'Set train route',
      'Railcars control', 'Move train along the route', 'Show list of trains and railcars',
      true
    )
    input = gets.chomp
    loop do
      case input
      when '1'
        create_train
      when '2'
        stations_menu
      when '3'
        routes_menu
      when '4'
        railcars_menu_for_train
      when '5'
        move_train_menu
      when '6'
        stations_and_trains
      when 'Exit'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕНЮ МАРШРУТОВ
  def routes_menu
    if @trains.empty?
      puts 'Add a train'
      create_train
    end
    if @stations.length < 2
      puts 'Add at least two stations'
      create_station
    end

    select_train_from_list_message
    number = gets.chomp
    train = select_train(number)

    create_route_intro
    input = gets.chomp
    loop do
      case input
      when '1'
        stations_menu
      when '2'
        create_route(train, true)
      when 'exit'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕНЮ МАРШРУТОВ ДЛЯ ВЫЗОВА ИЗ КОРНЕВОГО МЕНЮ
  def create_route_menu
    create_route_intro
    input = gets.chomp
    loop do
      case input
      when '1'
        stations_menu
      when '2'
        create_route(false)
      when 'выход'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕНЮ ВАГОНОВ ДЛЯ ВЫЗОВА ИЗ МЕНЮ ПОЕЗДОВ
  def railcars_menu_for_train
    select_train_from_list_message
    number = gets.chomp
    train = select_train(number)
    choices_list('Add railcar', 'Remove railcar', 'Back to trains control', 'Back to primary control')
    input = gets.chomp
    loop do
      case input
      when '1'
        railcar = create_railcar_for_train(train)
        train.add_railcar(railcar)
        @railcars << railcar
        trains_menu
      when '2'
        train.remove_railcar(railcar)
        trains_menu
      when '3'
        trains_menu
      when '4'
        show_menu
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕНЮ ДВИЖЕНИЯ ПОЕЗДОВ ПО МАРШРУТУ
  def move_train_menu
    select_train_from_list_message
    number = gets.chomp
    train = select_train(number)
    routes_menu if train.route.nil?
    choices_list(
      'Send to next station', 'Send to previous station',
      'Back to stations control', true
    )
    input = gets.chomp
    loop do
      case input
      when '1'
        train.move_to_next_station
        move_train_menu
      when '2'
        train.move_to_previous_station
        move_train_menu
      when '3'
        trains_menu
      when 'Exit'
        exit
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # МЕТОДЫ ДЛЯ СТАНЦИЙ:
  def create_station
    print 'Enter new station name: '
    loop do
      name = gets.chomp
      if station_exist?(name)
        print 'This station exists, try another one: '
      else
        @stations << Station.new(name)
        blank_line
        station_created_message(name)
        break
      end
    end
    stations_menu
  end

  def station_exist?(name)
    !!@stations.detect { |station| station.name == name }
  end

  def stations_list
    names = []
    @stations.each do |station|
      names << station.name
    end
    blank_line
    puts names.join(', ')
  end

  def select_station(name)
    selected_stations = @stations.select { |station| station.name == name }
    if selected_stations.empty?
      puts 'Enter correct name of the staton and try again.'
      routes_menu
    else
      selected_stations.first
    end
  end

  def stations_and_trains
    create_station if @stations.empty?
    create_train if @trains.empty?
    puts 'List of stations: '
    @stations.each do |station|
      if station.trains.length > 0
        trains = []
        station.trains.each do |train|
          trains << train.number
        end
        puts "Station #{station.name}, train: #{trains.join(', ')}"
      else
        puts "Station #{station.name}"
      end
    end
    puts 'List of trains:'
    trains_list
    trains_menu
  end

  # ДОПОЛНИТЕЛЬНЫЕ МЕТОДЫ ДЛЯ ПОЕЗДОВ
  def create_train
    print 'Enter a number for a new train: '
    loop do
      number = gets.chomp
      if train_exist?(number)
        print 'This number exists, enter another value:'
      else
        create_train_by_type(number)
        train_created_message(number)
        break
      end
    end
    trains_menu
  end

  def create_train_by_type(number)
    choices_list('Passenger train', 'Cargo train', false)
    input = gets.chomp
    loop do
      case input
      when '1'
        @trains << PassengerTrain.new(number)
        break
      when '2'
        @trains << CargoTrain.new(number)
        break
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  def train_exist?(number)
    !!@trains.detect { |train| train.number == number }
  end

  def trains_list
    numbers = []
    @trains.each do |train|
      numbers << train.number
    end
    puts numbers.join(', ')
  end

  def select_train(number)
    selected_trains = @trains.select { |train| train.number == number }
    if selected_trains.empty?
      puts 'Enter correct number of a train and try again.'
      routes_menu
    else
      selected_trains.first
    end
  end

  # МЕТОД ДЛЯ СОЗДАНИЯ МАРШРУТА
  def create_route(*args)
    # Количество входящих данных будет различаться в зависимости от места видимости метода.
    # При вызова из корня меню объект train не передаётся.
    route_for_train = args.last
    print 'Enter a name of first station: '
    input = gets.chomp
    first_station = select_station(input)
    print 'Enter a name of second station: '
    input = gets.chomp
    second_station = select_station(input)
    route = Route.new(first_station, second_station)
    loop do
      puts 'Do you want to add a station on a route?'
      choices_list('yes', 'no', false)
      input = gets.chomp
      case input
      when '1'
        puts 'Enater name of a station: '
        input = gets.chomp
        station = select_station(input)
        route.add_station(station)
      when '2'
        if route_for_train
          train = args.first
          train.set_route(route)
          @routes << route
          trains_menu
        else
          @routes << route
          create_route_menu
        end
      else
        enter_another_value
        input = gets.chomp
      end
    end
  end

  # СОЗДАТЬ ВАГОН ДЛЯ ПОЕЗДА
  def create_railcar_for_train(train)
    train.type == :cargo ? CargoRailcar.new : PassengerRailcar.new
  end

  # ДОПОЛНИТЕЛЬНЫЕ МЕТОДЫ ДЛЯ ВВОДА И ВЫВОДА
  def enter_another_value
    print 'Enter another value: '
  end

  def create_route_intro
    puts 'Following stations are available to plot a route:'
    stations_list
    puts 'Do you want to add new station or to continue with current ones?'
    choices_list('Add a new station', 'Continue with current ones', false)
  end

  def stations_menu_intro
    puts '==='
    puts 'Stations control:'
  end

  def trains_menu_intro
    puts '==='
    puts 'Trains control:'
  end

  def select_train_from_list_message
    puts "Enter the train's number from the list :"
    trains_list
  end

  def train_created_message(number)
    blank_line
    puts "Train #{number} has being succesfully added."
  end

  def station_created_message(name)
    blank_line
    puts "Station #{name} has being succesfully created."
  end

  # МЕТОД ДЛЯ ВЫВОДА СПИСКОВ С ВЫБОРОМ ДЛЯ МЕНЮ
  def choices_list(*options, extra_lines)
    puts 'Enter:'
    number = 1
    options.each do |option|
      puts "#{number} - #{option}"
      number += 1
    end
    if extra_lines
      puts 'Exit - to leave the application'
      print '> '
    end
  end

  def blank_line
    # Отступ для читаемости
    puts ''
  end
end
