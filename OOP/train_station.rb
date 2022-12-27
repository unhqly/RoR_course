=begin

$all_objects = []

def instance_exits(instance)
  if $all_objects.include?(instance.object_id)
    true
  else
    false
  end
end

=end

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
#   $all_objects << self.object_id
  end

  def accept_train(train)
#   if instance_exits(train)
    if train && !@trains.include?(train)
      @trains << train 
      train.station = self
      puts "Train successfully accepted at #{self.name} station"
    else 
      puts "Entered train doesn't exist or already at the station"
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

  def show_trains_list
    @amount_of_reight_trains = 0
    @amount_of_passenger_trains = 0
    @trains.each do |train| 
      if train.type == "reight"
        @amount_of_reight_trains += 1
      elsif train.type == "passenger"
        @amount_of_passenger_trains += 1
      end
    end
    puts "At #{self.name} station #{@amount_of_reight_trains} reight trains and #{@amount_of_passenger_trains} passenger trains"
  end
end

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
#   $all_objects << self.object_id
  end

  def add_station(position, station)
#   if instance_exits(station)
    if station && !@stations.include?(station)
      @stations.insert(position - 1, station)
    else
      puts "Station doesn't exist or already in route list"
    end     
  end

  def delete_station(station)
#   if instance_exits(station)
    if station
      if @stations.include?(station)
        if @stations.length > 2 
          @stations.delete(station)
        else
          puts "Route must have at least two stations"
        end
      else 
        puts "There is no #{station.name} station in route list"
      end
    else
      puts "#{station.name} station doesn't exist"
    end
  end
  def show_route
    @stations.each { |station| print "#{station.name} "}
  end
end

class Train
  attr_reader :speed, :number_of_boxcars, :type
  attr_accessor :station

  def initialize(number, type, number_of_boxcars)
    @number = number
    @type = type  
    @number_of_boxcars = number_of_boxcars
    @speed = 0
    @station
#   $all_objects << self.object_id
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
#   if instance_exits(route)
    if route
      @route = route
      @station = @route.stations[0]
      puts "Route successfully added at train's route list"
      @station.accept_train(self)
    else
      puts "Entered route doesn't exist"
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
    if @route.stations.index(@station) - 1 >= 0
      @route.stations[@route.stations.index(@station) - 1]
    else
      puts "There is no previous station"
    end
  end

  def next_station
    if @route.stations[@route.stations.index(@station) + 1]
      @route.stations[@route.stations.index(@station) + 1]
    else
      puts "There is no next station"
    end
  end
end
