require_relative 'boxcar'

class PassengerBoxcar < Boxcar

  attr_accessor :number, :seats_quantity

  def initialize(number, seats_quantity)
    @number = number
    @seats_quantity = seats_quantity.to_i
    @free_seats_quantity = @seats_quantity
    @occupied_seats_quantity = 0
    validate!
  end

  def take_seat
    @occupied_seats_quantity += 1
    @free_seats_quantity -= 1
  end

  def free_seats
    @free_seats_quantity
  end

  def occupied_seats
    @occupied_seats_quantity
  end

  protected

  def validate!
    raise ArgumentError, "Number is empty" if number.nil? || number == ''
    raise ArgumentError, "Seats quantity is empty" if seats_quantity.nil? || seats_quantity == ''
  end
end
