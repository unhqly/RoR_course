# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  include Validation

  NUMBER_FORMAT = /^[0-9a-z]{3}-*[0-9a-z]{2}$/.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :boxcar, :type, CargoBoxcar

  def add_boxcar(boxcar)
    #raise RuntimeError unless boxcar.is_a?(CargoBoxcar)
    validate!
    super
  end
end
