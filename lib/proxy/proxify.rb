module Proxy

  class ProxyContainer

    attr_reader :subject, :accepts

    def initialize(subject, accepts)
      @subject = subject
      @accepts = accepts
    end

    def method_missing(method, *args, &block)
      if @accepts.include?(method)
        return subject.send(method, *args, &block)
      else
        raise NoMethodError, method.to_s
      end
    end
  end

  module ProxifyClass
    attr_accessor :acceptable

    def accepts(*ting)
      @acceptable = ting
    end
  end

  module Proxify
    extend Proxy::ProxifyClass

    def self.included(base)
      base.send :extend, Proxy::ProxifyClass
    end

    def proxy
      class_name = "#{self.class.name}Proxy"
      klass = if k = class_exists?(class_name)
        k
      else
        Object.const_set(class_name,ProxyContainer)
      end

      klass.new(self, self.class.acceptable)
    end

    def class_exists?(class_name)
      Object.const_get(class_name)
    rescue NameError
      return false
    end
  end
end
