require_relative 'train'

class PassengerTrain < Train
  def add_boxcar(boxcar)
    if boxcar.is_a?(PassengerBoxcar)
      super 
    else
      raise RuntimeError
    end
  end
end
