require_relative 'train'

class CargoTrain < Train
  def add_boxcar(boxcar)
    if boxcar.is_a?(CargoBoxcar)
      super 
    else
      raise RuntimeError
    end
  end
end
