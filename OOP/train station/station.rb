class Station
  include InstanceCounter
  include InstanceValidation

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def accept_train(train)
      @trains << train 
      train.station = self
      puts "Train successfully accepted at #{self.name} station"
  end

  def send_train(train)
      @trains.delete(train)
      puts "Train left #{self.name} station"
  end 

  def show_trains_list(type)
    @amount_of_trains = 0
    @trains.each { |train| @amount_of_trains += 1 if train.type == type }
    @amount_of_trains
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  protected

  #all methods listed below have to be not allowed for user

  def validate!
    raise ArgumentError, "Name is empty" if name.nil? || name == ''
  end
end
