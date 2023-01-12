require_relative 'train'

class CargoTrain < Train
  def add_boxcar(boxcar)
    if boxcar.is_a?(CargoBoxcar)
      super 
    else
      puts "Boxcar has wrong type"
    end
  end
end
