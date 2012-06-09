require 'spec_helper'

describe "Smartdict" do
  describe '.info' do
    subject { Smartdict.info }

    its(:version) { should =~ /\d{1,2}\.\d{1,2}\.\d{1,2}/ }
    its(:author)  { should == "Sergey Potapov"            }
    its(:email)   { should == "open.smartdict@gmail.com"  }
    its(:url)     { should == "http://smartdict.net"      }
  end
end
