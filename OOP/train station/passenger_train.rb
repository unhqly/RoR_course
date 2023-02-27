# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def add_boxcar(boxcar)
    raise RuntimeError unless boxcar.is_a?(PassengerBoxcar)

    super
  end
end
