require 'spec_helper'

describe CloudAccess::As::Create::AutoScalingGroup do
  def new_instance(aws_data)
    CloudAccess::As::Create::AutoScalingGroup.new(aws_data)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_instance( 'OK-Created auto scaling group' )
  
      o.is_valid?.should == true
    end

  end

end
