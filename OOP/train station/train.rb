# frozen_string_literal: true

class Train
  include CompanyName
  include InstanceCounter
  include Validation 

  attr_reader :speed, :type, :number, :boxcars
  attr_accessor :station

  NUMBER_FORMAT = /^[0-9a-z]{3}-*[0-9a-z]{2}$/.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @speed = 0
    @boxcars = []
    validate!
    register_instance
  end

  def add_boxcar(boxcar)
    @boxcars << boxcar if @speed.zero?
  end

  def delete_boxcar(boxcar)
    @boxcars.delete(boxcar) if @speed.zero?
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.accept_train(self)
  end

  def move_forward
    return unless next_station

    @station.send_train(self)
    @station = @route.stations[@route.stations.index(@station) + 1]
    @station.accept_train(self)
  end

  def move_back
    return unless previous_station

    @station.send_train(self)
    @station = @route.stations[@route.stations.index(@station) - 1]
    @station.accept_train(self)
  end

  def self.find(number)
    ObjectSpace.each_object(self).to_a.find { |train| train.number == number }
  end

  def previous_station
    raise RuntimeError unless @route.stations.index(@station) - 1 >= 0

    @route.stations[@route.stations.index(@station) - 1]
  end

  def next_station
    raise RuntimeError unless @route.stations[@route.stations.index(@station) + 1]

    @route.stations[@route.stations.index(@station) + 1]
  end

  def show_boxcars_info(&block)
    @boxcars.each { |boxcar| block.call(boxcar) }
  end

  protected

  # all methods listed below have to be not allowed for user

  def increase_speed
    @speed += 30
  end

  def stop
    @speed = 0
  end
end
