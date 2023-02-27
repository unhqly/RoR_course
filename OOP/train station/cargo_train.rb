# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def add_boxcar(boxcar)
    raise RuntimeError unless boxcar.is_a?(CargoBoxcar)

    super
  end
end
