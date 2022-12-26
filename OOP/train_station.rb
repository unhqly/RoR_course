class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end
  
  def accept_train(train)
    if train
      @trains << train 
      train.station = self
      puts "Train successfully accepted at #{self.name} station"
    else 
      puts "There is no entered train"
    end
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      puts "Train left #{self.name} station"
    else
      puts "There is no entered train on #{self.name} station"
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
  attr_reader :speed, :number_of_boxcars
  attr_accessor :station

  def initialize(number, type, number_of_boxcars)
    @number = number
    @type = type  
    @number_of_boxcars = number_of_boxcars
    @speed = 0
    @station
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
      puts "Route successfully added at train's route list"
      @station.accept_train(self)
    else
      puts "There is no route in route list"
    end
  end

  def move_forward
    if @route.stations[@route.stations.index(@station) + 1]
      @station.send_train(self)
      @station = @route.stations[@route.stations.index(@station) + 1]
      @station.accept_train(self)
    else 
      puts "Train at final station"
    end
  end

  def move_back
    if @route.stations.index(@station) - 1 >= 0
      @station.send_train(self)
      @station = @route.stations[@route.stations.index(@station) - 1]
      @station.accept_train(self)
    else
      puts "Train at first station"
    end
  end

  def previous_station
    #@route.stations.index(@station) - 1 >= 0 ? @route.stations[@route.stations.index(@station) - 1] : puts "There is no previous station"
    if @route.stations.index(@station) - 1 >= 0
      @route.stations[@route.stations.index(@station) - 1]
    else
      puts "There is no previous station"
    end
  end

  def next_station
    #@route.stations[@route.stations.index(@station) + 1] ? @route.stations[@route.stations.index(@station) + 1] : puts "There is no next station"
    if @route.stations[@route.stations.index(@station) + 1]
      @route.stations[@route.stations.index(@station) + 1]
    else
      puts "There is no next station"
    end
  end
end

#TODO: when move forward/back train has to appear/disappear in trains array at station