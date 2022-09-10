class Train
  attr_accessor :speed
  attr_reader :type, :route, :carriages_count

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @speed = 0
  end

  def increase_speed(speed)
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

  def current_station
    route.stations[@current_station_index]
  end

  def previous_station
    route.stations[@current_station_index - 1] unless @current_station_index == 0
  end

  def next_station
    route.stations[@current_station_index + 1] unless @current_station_index == route.stations.size - 1
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
