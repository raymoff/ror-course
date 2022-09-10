class Route
  attr_reader :stations

  def initialize(start_station, finite_station)
    @stations = [start_station, finite_station]
  end

  def start_station
    stations.first
  end

  def finite_station
    stations.last
  end

  def add_intermediate_station(station)
    stations.insert(-2, station)
  end

  def delete_intermediate_station(station)
    # stations.delete(station)
    allowed_stations = stations.slice(1...-1)
    stations.delete(station) if allowed_stations.include?(station)
  end

  def show_stations
    stations.each { |station| puts station }
  end
end
