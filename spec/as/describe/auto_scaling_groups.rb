require 'spec_helper'

describe CloudAccess::As::Describe::AutoScalingGroups do
  
  aws_data = %Q{AUTO-SCALING-GROUP,lll-as-group-dev,lll-launch-cfg-dev,us-east-1d,2011-05-06T22:21:54.364Z,(nil),EC2,0,0,0,300,0,(nil),(nil),arn:aws:autoscali...}
  
  def new_instance(aws_data)
    CloudAccess::As::Describe::AutoScalingGroups.new(aws_data)
  end
  
  describe "initialization" do
    it "creates its array" do
      o = new_instance( aws_data )
      oo = o[0]
      
      oo.auto_scaling_group.should == 'AUTO-SCALING-GROUP'
      oo.group_name.should == 'lll-as-group-dev'
      oo.launch_config.should == 'lll-launch-cfg-dev'
      oo.availability_zones.should == ['us-east-1d']
      oo.created.should == Time.parse('2011-05-06T22:21:54.364Z')
      oo.load_balancers.should == []
      oo.health_check.should == 'EC2'
      oo.min_size.should == 0
      oo.max_size.should == 0
      oo.desired_capacity.should == 0
      oo.default_cooldown.should == 300
      oo.grace_period.should == 0
      oo.vpc_identifier.should == nil
      oo.placement_group.should == nil
      oo.group_arn.should == 'arn:aws:autoscali...'
    end

  end

  describe "handles empty respone" do
    it "is not launch_config" do
      o = new_instance( 'BLAH,lll-as-group-dev,lll-launch-cfg-dev,us-east-1d,2011-05-06T22:21:54.364Z,(nil),EC2,0,0,0,300,0,(nil),(nil),arn:aws:autoscali...' )
  
      o.empty?.should == true
    end
    
    it "does not crash on empty response" do
      o = new_instance( 'No AutoScalingGroups found' )
  
      o.empty?.should == true
    end

  end

end
