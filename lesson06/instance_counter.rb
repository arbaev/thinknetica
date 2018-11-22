module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    private

    def instances_increment
      @@instances += 1
    end
  end

  module InstanceMethods

    protected

    def register_instance
      self.class.send :instances_increment
    end
  end
end
