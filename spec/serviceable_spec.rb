require 'spec_helper'

class Foo
  include Proxify::Serviceable

  service :hello, :say, :twice, :tell

  class << self
    def hello
      "world"
    end

    def goodbye
      raise "BOOM!"
    end

    def say(something)
      something
    end

    def twice(something, another)
      [something, another]
    end

    def tell
      yield
    end

  end

end

describe Foo do

  it "defines a FooService class" do
    Object.const_get('FooService')
  end

  it "defines the methods on FooService" do
    FooService.methods.should include :hello, :say, :twice, :tell
    FooService.methods.should_not include :goodbye
  end

  it "services the hello message" do
    FooService.hello.should == "world"
  end

  it "services the say message" do
    FooService.say("hello").should == "hello"
  end

  it "services the twice message" do
    FooService.twice("hello", "world").should == ["hello", "world"]
  end

  it "services the yield message" do
    called = false
    FooService.tell { called = true }
    called.should == true
  end

end
