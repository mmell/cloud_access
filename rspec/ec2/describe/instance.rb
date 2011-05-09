require File.expand_path(File.dirname(__FILE__) + '/../../../lib/ec2')

describe CloudAccess::Ec2::Describe::Instance do
  
  aws_data = 'INSTANCE	i-48603227	ami-da679bb3	ec2-50-17-246-0.compute-1.amazonaws.com	ip-10-83-42-165.ec2.internal	running		0		m1.large	2011-04-23T20:56:07+0000	us-east-1d	aki-427d952b			monitoring-disabled	50.17.246.0	10.83.42.165			ebs					paravirtual	xen		sg-8c9fffe5	default'
  
  describe "initialize" do
  
    it "creates an object" do
      attachment = CloudAccess::Ec2::Describe::Instance.new(aws_data)

      attachment.instance_id.should == 'i-48603227'
      attachment.ami_id.should == 'ami-da679bb3'
      attachment.public_dns.should == 'ec2-50-17-246-0.compute-1.amazonaws.com'
      attachment.private_dns.should == 'ip-10-83-42-165.ec2.internal'
      attachment.instance_state.should == 'running'
          
    end

  end

end
