require 'spec_helper'

describe CloudAccess::System do

  def new_system
    CloudAccess::System.new
  end
  
  describe "basic accessors" do
    it "is not natty" do
      o = new_system
      
      # FIXME handle running tests on ubuntu
      o.is_ubuntu?.should == false
      o.is_natty?.should == false
    end

  end

end
