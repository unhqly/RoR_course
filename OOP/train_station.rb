class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end
  
  def accept_train(train)
    if train
      @trains << train 
      train.station = self
      puts "#{train.name} successfully accepted at #{self.name} station"
    else 
      puts "There is no #{train.name} train"
    end
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      puts "#{train.name} left #{self.name} station"
    else
      puts "There is no train #{train.name} on #{self.name} station"
    end
  end 

  def show_reight_trains_list
    @trains.each { |train| train if train.type == 'reight' }
  end
  def show_passenger_trains_list
    @trains.each { |train| puts train if train.type == 'passenger' }
  end
end

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(position, station)
    @stations.insert(position - 1, station)     
  end

  def delete_station(station)
    #stations.length > 2 ? stations.delete(station) : puts "Route must have at least two stations"
    if @stations.length > 2 
      @stations.delete(station)
    else
      puts "Route must have at least two stations"
    end
  end
  def show_route
    @stations.each { |station| print "#{station.name} "}
  end
end

class Train
  attr_reader :speed, :number_of_boxcars, :station

  def initialize(number, type, number_of_boxcars)
    @number = number
    @type = type  
    @number_of_boxcars = number_of_boxcars
    @speed = 0
  end

  def increase_speed
    @speed += 30
  end

  def stop
    @speed = 0
  end

  def add_boxcar
    @number_of_boxcars += 1 if @speed == 0
  end

  def delete_boxcar
    @number_of_boxcars -= 1 if @number_of_boxcars > 0 && @speed == 0
  end

  def add_route(route)
    if route
      @route = route
      @station = @route.stations[0]
    else
      puts "There is no route in route list"
    end
  end

  def move_forward
    @station = @route[@route.find_index(@station) + 1] if @route[@route.find_index(@station) + 1]
  end

  def move_back
    @station = @route[@route.find_index(@station) - 1] if @route[@route.find_index(@station) - 1] 
  end

  def previous_station
    #@route[@route.find_index(@station) - 1] ? @route[@route.find_index(@station) - 1] : puts "There is no previous station"
    if @route[@route.find_index(@station) - 1]
      @route[@route.find_index(@station) - 1]
    else
      puts "There is no previous station"
    end
  end

  def next_station
    #@route[@route.find_index(@station) + 1] ? @route[@route.find_index(@station) + 1] : puts "There is no next station"
    if @route[@route.find_index(@station) + 1]
      @route[@route.find_index(@station) + 1]
    else
      puts "There is no next station"
    end
  end
end

#TODO: when move forward/back train has to appear/disappear in trains array at station