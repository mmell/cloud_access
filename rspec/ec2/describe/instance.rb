require File.expand_path(File.dirname(__FILE__) + '/../../../lib/ec2')

describe CloudAccess::Ec2::Describe::Instance do
  
  aws_data = 'INSTANCE	i-c7cd56ad	ami-b232d0db	ec2-72-44-52-124.compute-1.amazonaws.com	domU-12-31-39-01-76-06.compute-1.internal	running	GSG_Keypair	0	m1.small	2010-08-17T01:15:16+0000	us-east-1b	aki-94c527fd	ari-96c527ff	monitoring-disabled	72.44.52.124	10.255.121.240	ebs	paravirtual	xen'
  
  describe "initialize" do
  
    it "creates an object" do
      attachment = CloudAccess::Ec2::Describe::Instance.new(aws_data)

      attachment.instance_id.should == 'i-c7cd56ad'
      attachment.ami_id.should == 'ami-b232d0db'
      attachment.public_dns.should == 'ec2-72-44-52-124.compute-1.amazonaws.com'
      attachment.private_dns.should == 'domU-12-31-39-01-76-06.compute-1.internal'
      attachment.instance_state.should == 'running'
          
    end

  end

end
