# frozen_string_literal: true

require_relative 'boxcar'

class PassengerBoxcar < Boxcar
  include Validation

  validate :number, :presence
  validate :full_volume, :presence

  def take_seat
    @filled_volume += 1
    @free_volume -= 1
  end
end
