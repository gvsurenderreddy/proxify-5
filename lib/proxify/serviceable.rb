module Proxify

  class ServiceContainer

  end

  module ServiceableClass
    def service(*args)

    end
  end

  module Serviceable
    extend Proxify::ServiceableClass
    extend Proxify::Base

    def self.included(base)
      base.send :extend, Proxify::ServiceableClass
      class_name = "#{base.name}Service"
      find_or_create_class(class_name, ServiceContainer)
    end

  end
end

