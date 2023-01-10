require_relative 'train'

class PassengerTrain < Train
  def add_boxcar(boxcar)
      super if boxcar.is_a?(PassengerBoxcar)
  end
end