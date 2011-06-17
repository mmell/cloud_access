require 'spec_helper'

describe CloudAccess::As::Delete::AutoScalingGroup do
  def new_instance(aws_data)
    CloudAccess::As::Delete::AutoScalingGroup.new(aws_data)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_instance( 'OK-Deleted launch configuration' )
  
      o.is_valid?.should == true
    end

  end

end
