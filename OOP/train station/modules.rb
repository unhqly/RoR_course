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
  attr_accessor :instances
  
  @@instances = 0

  def self.instances
    @@instances
  end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      InstanceCounter.instances
    end
  end

  protected

  module InstanceMethods
    def register_instance
      InstanceCounter.instances += 1
    end
  end
end