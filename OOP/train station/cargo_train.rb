require_relative 'train'

class CargoTrain < Train
  def add_boxcar(boxcar)
      super if boxcar.is_a?(CargoBoxcar)
  end
end