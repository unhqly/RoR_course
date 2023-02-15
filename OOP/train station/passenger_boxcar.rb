require_relative 'boxcar'

class PassengerBoxcar < Boxcar

  def take_seat
    @filled_volume += 1
    @free_volume -= 1
  end
end
