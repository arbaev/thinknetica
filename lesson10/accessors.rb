module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def strong_attr_accessor(name, type)
      define_method(name) { instance_variable_get("@#{name}") }

      define_method("#{name}=".to_sym) do |value|
        if value.class == type
          instance_variable_set("@#{name}", value)
        else
          raise ArgumentError, 'Неверный тип инстанс-переменной'
        end
      end
    end

    def attr_accessor_with_history(*names)
      names.each do |name|
        sym_name = "@#{name}".to_sym
        sym_name_history = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(sym_name) }

        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(sym_name_history) || []
          instance_variable_set(sym_name_history, history << instance_variable_get(sym_name))
          instance_variable_set(sym_name, value)
        end

        define_method("#{name}_history") { instance_variable_get(sym_name_history) }
      end
    end
  end
end
