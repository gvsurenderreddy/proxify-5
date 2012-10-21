require 'spec_helper'

class Proxied
  include Proxy::Proxify

  accepts :hello

  def hello
    "world"
  end

  def goodbye
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
  end


end
