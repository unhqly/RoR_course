require_relative 'boxcar'

class CargoBoxcar < Boxcar

  def fill_volume(size)
    @filled_volume += size.to_i
    @free_volume -= size.to_i
  end
end
