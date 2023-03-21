# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  include Validation

  NUMBER_FORMAT = /^[0-9a-z]{3}-*[0-9a-z]{2}$/.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :boxcar, :type, PassengerBoxcar

  def add_boxcar(boxcar)
    #raise RuntimeError unless boxcar.is_a?(PassengerBoxcar)
    @boxcar = boxcar
    validate!
    super
  end
end
