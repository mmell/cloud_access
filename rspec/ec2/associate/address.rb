require File.expand_path(File.dirname(__FILE__) + '/../../ec2')

describe CloudAccess::Ec2::Associate::Address do
  
  aws_data = 'ADDRESS	192.0.2.1	i-43a4412a'
  
  describe "initialize" do
  
    it "creates an object" do
      attachment = CloudAccess::Ec2::Associate::Address.new(aws_data)

#      attachment.type.should == 'ADDRESS'
      attachment.elastic_ip.should == '192.0.2.1'
      attachment.instance_id.should == 'i-43a4412a'
      attachment.association_id.should == nil
    end

  end

end
