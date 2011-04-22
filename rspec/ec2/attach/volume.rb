require File.expand_path(File.dirname(__FILE__) + '/../../ec2')

describe CloudAccess::Ec2::Attach::Volume do
  
  aws_data = 'ATTACHMENT	vol-4d826724	i-6058a509	/dev/sdh	attaching	2008-02-14T00:15:00+0000'
  
  describe "initialize" do
  
    it "creates an object" do
      attachment = CloudAccess::Ec2::Attach::Volume.new(aws_data)

#      attachment.type.should == 'ATTACHMENT'
      attachment.id.should == 'vol-4d826724'
      attachment.instance_id.should == 'i-6058a509'
      attachment.mount_point.should == '/dev/sdh'
      attachment.state.should == 'attaching'
      attachment.attachment_timestamp.should == Time.parse('2008-02-14T00:15:00+0000')
    end

  end

end
