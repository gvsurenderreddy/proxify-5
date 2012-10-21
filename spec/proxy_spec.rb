require 'spec_helper'

class Proxied
  include Proxy::Proxify

  proxy :hello, :say, :tell

  def hello
    "world"
  end

  def goodbye
    "world"
  end

  def say(something)
    something
  end

  def tell
    yield
  end

end

class AnotherProxied
  include Proxy::Proxify

  proxy :hello

  def hello
    "world"
  end
end

describe Proxied do

  subject do
    proxied = Proxied.new
    proxied.proxy
  end

  describe "Class Type" do
    it "has the type of ProxiedProxy" do 
      subject.is_a?(ProxiedProxy).should == true
    end
  end

  describe ".accept" do
    it "accepts hello and rejects goodbye" do
      subject.hello.should == "world"
      expect { subject.goodbye }.to raise_error
    end

    it "can accept methods with arguments" do
      subject.say("hello").should == "hello"
    end

    it "can accept a block" do
      called = false
      subject.tell do
        called = true
      end
      called.should == true
    end
  end

  describe "a second proxied class" do
    it "can handle more than one" do
      another = AnotherProxied.new.proxy
      subject.hello.should == another.hello
    end
  end
end
