require 'spec_helper'

describe CloudAccess::Ec2::Attach::Volume do
  
  aws_data = 'ATTACHMENT	vol-4d826724	i-6058a509	/dev/sdh	attaching	2008-02-14T00:15:00+0000'
  
  describe "initialize" do
  
    it "creates an object" do
      o = CloudAccess::Ec2::Attach::Volume.new(aws_data)

#      o.type.should == 'ATTACHMENT'
      o.id.should == 'vol-4d826724'
      o.instance_id.should == 'i-6058a509'
      o.device.should == '/dev/sdh'
      o.state.should == 'attaching'
      o.timestamp.should == Time.parse('2008-02-14T00:15:00+0000')
    end

  end

end
