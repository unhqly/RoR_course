# frozen_string_literal: true

class Boxcar
  include CompanyName
  include InstanceValidation

  attr_reader :number, :full_volume, :free_volume, :filled_volume

  def initialize(number, full_volume)
    @number = number
    @full_volume = full_volume.to_i
    @free_volume = @full_volume
    @filled_volume = 0
    validate!
  end

  def available_volume
    @free_volume
  end

  def occupied_volume
    @filled_volume
  end

  protected

  # all methods listed below have to be not allowed for user

  def validate!
    raise ArgumentError, 'Number is empty' if number.nil? || number == ''
    raise ArgumentError, "Boxcar's volume / amount of seats is not specified" if full_volume.nil? || full_volume == ''
  end
end
