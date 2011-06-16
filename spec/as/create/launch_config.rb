require 'spec_helper'

describe CloudAccess::As::Create::LaunchConfig do
  def new_instance(aws_data)
    CloudAccess::As::Create::LaunchConfig.new(aws_data)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_instance( 'OK-Created launch configuration' )
  
      o.is_valid?.should == true
    end

  end

end
