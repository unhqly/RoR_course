class Train
  include CompanyName
  include InstanceCounter
  include InstanceValidation

  attr_reader :speed, :number_of_boxcars, :type, :number
  attr_accessor :station

  NUMBER_FORMAT = /^[0-9a-z]{3}-*[0-9a-z]{2}$/

  def initialize(number)
    @number = number
    @speed = 0
    @boxcars = []
    self.register_instance
    validate!
  end

  def add_boxcar(boxcar)
    @boxcars << boxcar if @speed == 0
    puts "Boxcar №#{boxcar.number} successfully added to train №#{self.number}"
  end

  def delete_boxcar(boxcar)
    @boxcars.delete(boxcar) if @speed == 0
    puts "Boxcar №#{boxcar.number} deleted from train №#{self.number}"
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

  def self.find(number)
    ObjectSpace.each_object(self).to_a.find { |train| train.number == number }
  end

  protected

  #all methods listed below have to be not allowed for user

  def validate!
    raise ArgumentError, "Number has wrong format (Examples of correct format: aA1-2a or 23a4F)" if number !~ NUMBER_FORMAT
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

  def increase_speed
    @speed += 30
  end

  def stop
    @speed = 0
  end
end
