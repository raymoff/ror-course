# Класс Станция
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_trains_list
    @trains.each { |train| puts train }
  end

  def trains_types(type)
    @trains.select{ |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

# Класс Маршрут
class Route
  attr_reader :stations

  def initialize(start_station, finite_station)
    @stations = [start_station, finite_station]
  end

  def add_intermediate_station(station)
    @stations.insert(1, station)
  end

  def delete_intermediate_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each { |station| puts station }
  end
end

# Класс Поезд
class Train
  attr_reader :type, :speed, :route, :carriages_count

  def initialize(number, type, carriages_count, :speed)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @speed = speed
  end

  def increase_speed (speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages_count += 1 if speed == 0
  end

  def remove_carriage
    @carriages_count -= 1 if speed == 0 && carriages_count > 0
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    route.start_station.accept_train(self)
  end

  def move_to_next_station
    if next_station
      current_station.send_train(self)
      next_station.accept_train(self)
      @current_station_index += 1
    end
  end

  def move_to_previous_station
    if previous_station
      current_station.send_train(self)
      previous_station.accept_train(self)
      @current_station_index -= 1
    end
  end
end
