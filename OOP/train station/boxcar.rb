# frozen_string_literal: true

class Boxcar
  include CompanyName
  include Validation

  attr_reader :number, :full_volume, :free_volume, :filled_volume

  validate :number, :presence
  validate :full_volume, :presence

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
end
