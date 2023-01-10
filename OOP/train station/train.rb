class Train
  attr_reader :speed, :number_of_boxcars, :type
  attr_accessor :station

  def initialize(number)
    @number = number
    @speed = 0
    @boxcars = []
  end

  def add_boxcar(boxcar)
    @boxcars << boxcar if @speed == 0
  end

  def delete_boxcar(boxcar)
    @boxcars.delete(boxcar) if @speed == 0
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.accept_train(self)
    puts "Route successfully added at train's route list"
  end

  def move_forward
    if next_station
      @station.send_train(self)
      @station = @route.stations[@route.stations.index(@station) + 1]
      @station.accept_train(self)
    end
  end

  def move_back
    if previous_station
      @station.send_train(self)
      @station = @route.stations[@route.stations.index(@station) - 1]
      @station.accept_train(self)
    end
  end

  protected

  #all methods listed below have to be not allowed for user

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

  def increase_speed
    @speed += 30
  end

  def stop
    @speed = 0
  end
end
