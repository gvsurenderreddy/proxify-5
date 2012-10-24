module Proxify

  class Proxy

    attr_reader :subject, :proxies

    def initialize(subject, proxies)
      @subject = subject
      @proxies = proxies
    end

    def method_missing(method, *args, &block)
      if proxies.include?(method)
        return subject.send(method, *args, &block)
      else
        raise NoMethodError, method.to_s
      end
    end
  end

  module ProxifyClass
    attr_accessor :proxies

    def proxy(*args)
      @proxies = args
    end
  end

  module Me
    extend Proxify::ProxifyClass
    include Proxify::Base

    def self.included(base)
      base.send :extend, Proxify::ProxifyClass
    end

    def proxify
      class_name = "#{self.class.name}Proxy"
      klass = find_or_create_class(class_name, Proxy)
      klass.new(self, self.class.proxies)
    end

  end

end
