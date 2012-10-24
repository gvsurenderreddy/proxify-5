require 'spec_helper'

class Foo
  include Proxify::Serviceable

  service :hello

  class << self
    def hello
      "world"
    end
  end

end

describe Foo do

  it "defines a FooService class" do
    Object.const_get('FooService')
  end

end
