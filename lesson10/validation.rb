module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validata
      @validata ||= []
    end

    def validate(atr, type, *args)
      validata
      @validata << { atr: atr, type: type, args: args }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    def validate!
      self.class.validata.each do |check|
        atr = instance_variable_get("@#{check[:atr]}")
        send("validate_#{check[:type]}".to_sym, atr, *check[:args])
      end
    end

    protected

    def validate_presence(atr)
      raise ArgumentError, 'Атрибут не установлен или пустой' if atr.to_s.empty?
    end

    def validate_class(atr, arg)
      raise ArgumentError, "Атрибут не соответствует классу #{arg}" if atr.class != arg
    end

    def validate_format(atr, arg)
      raise ArgumentError, "Атрибут не соответствует формату #{arg}" if atr !~ arg
    end

    def validate_equal(atr, arg)
      get_arg = instance_variable_get("@#{arg}")
      raise ArgumentError, '=> Начальная и конечная станции должны быть разные' if atr == get_arg
    end

    def validate_include(atr, arg)
      get_arg = [arg].flatten
      raise ArgumentError, "=> Не соответствует типу #{get_arg}" unless get_arg.include?(atr)
    end
  end
end
