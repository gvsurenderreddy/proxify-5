module Proxify

  class Service

    class << self

      attr_accessor :serviceable
      attr_accessor :subject

      def serviceable=(serviceable)
        @@serviceable = serviceable
        puts @@subject
        @@serviceable.each do |method|
          define_singleton_method(method) do |*args, &block|
            @@subject.send(method.to_sym, *args, &block)
          end
        end
      end

      def subject=(subject)
        @@subject = subject
      end

    end

  end

  module ServiceableClass
    include Proxify::Base

    attr_accessor :serviceable

    def service(*args)
      @serviceable = args
      class_name = "#{self.name}Service"
      klass = find_or_create_class(class_name, Service)
      klass.subject = self
      klass.serviceable = args
    end
  end

  module Serviceable
    extend Proxify::ServiceableClass

    def self.included(base)
      base.send :extend, Proxify::ServiceableClass
    end

  end
end

