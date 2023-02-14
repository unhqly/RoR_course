require_relative 'boxcar'

class CargoBoxcar < Boxcar

  attr_accessor :number, :full_volume

  def initialize(number, full_volume)
    @number = number
    @full_volume = full_volume
    @free_volume = full_volume
    @filled_volume = 0
    validate!
  end

  def fill_volume(size)
    @filled_volume += size
    @free_volume -= size
  end

  def available_volume
    @free_volume
  end

  def occupied_volume
    @filled_volume
  end

  protected

  def validate!
    raise ArgumentError, "Number is empty" if number.nil? || number == ''
    raise ArgumentError, "Boxcar's volume is not specified" if full_volume.nil? || full_volume == ''
  end
end
