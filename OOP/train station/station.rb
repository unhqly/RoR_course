# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains, :block

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def accept_train(train)
    @trains << train
    train.station = self
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_list(type)
    @amount_of_trains = 0
    @trains.each { |train| @amount_of_trains += 1 if train.type == type }
    @amount_of_trains
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def show_trains_info(&block)
    @trains.each { |train| block.call(train) }
  end
end
