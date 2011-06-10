require 'spec_helper'

describe CloudAccess::Ec2::Associate::Address do
  
  aws_data = 'ADDRESS	192.0.2.1	i-43a4412a'
  
  describe "initialize" do
  
    it "creates an object" do
      o = CloudAccess::Ec2::Associate::Address.new(aws_data)

#      o.type.should == 'ADDRESS'
      o.elastic_ip.should == '192.0.2.1'
      o.instance_id.should == 'i-43a4412a'
      o.association_id.should == nil
    end

  end

end
