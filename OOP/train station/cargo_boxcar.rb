# frozen_string_literal: true

require_relative 'boxcar'

class CargoBoxcar < Boxcar
  include Validation

  validate :number, :presence
  validate :full_volume, :presence

  def fill_volume(size)
    @filled_volume += size.to_i
    @free_volume -= size.to_i
  end
end
