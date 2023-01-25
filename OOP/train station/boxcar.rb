class Boxcar
  include CompanyName
  attr_reader :number

  def initialize(number)
    @number = number
  end
end
