class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(position, station)
    @stations.insert(position - 1, station)   
  end

  def delete_station(station)
    @stations.delete(station)
  end
  def show_route
    @stations.each { |station| print "#{station.name} "}
  end
end
