require 'spec_helper'

describe CloudAccess::Ec2::Associate::Address do
  
  aws_data = 'ADDRESS	192.0.2.1	i-43a4412a'
  
  describe "initialize" do
  
    it "creates an object" do
      address = CloudAccess::Ec2::Associate::Address.new(aws_data)

#      address.type.should == 'ADDRESS'
      address.elastic_ip.should == '192.0.2.1'
      address.instance_id.should == 'i-43a4412a'
      address.association_id.should == nil
    end

  end

end
