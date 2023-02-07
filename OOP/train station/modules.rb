module CompanyName
  attr_accessor :company_name

  def get_company_name
    self.company_name
  end

  def set_company_name(company_name)
    self.company_name = company_name
  end
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  protected

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end
end

module InstanceValidation
  def valid?
    self.validate!
    true
  rescue ArgumentError
    false
  end 
end