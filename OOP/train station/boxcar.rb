class Boxcar
  include CompanyName
  include InstanceValidation

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end
  
  protected

  #all methods listed below have to be not allowed for user

  def validate!
    raise ArgumentError, "Number is empty" if number.nil? || number == ''
  end
end
