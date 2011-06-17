require 'spec_helper'

describe CloudAccess::As::Describe::AutoScalingGroup do
  # :auto_scaling_group, :group_name, :launch_config, :availability_zones, :created, :load_balancers, :health_check, :min_size, :max_size, :desired_capacity, 
  # :default_cooldown, :grace_period, :vpc_identifier, :placement_group, :group_arn
  
  def new_instance(aws_data)
    arr = CloudAccess::As.parse_csv(aws_data)[0]
    CloudAccess::As::Describe::AutoScalingGroup.new(arr)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_instance( 'AUTO-SCALING-GROUP,lll-as-group-dev,lll-launch-cfg-dev,us-east-1d,2011-05-06T22:21:54.364Z,(nil),EC2,0,0,0,300,0,(nil),(nil),arn:aws:autoscali...' )
  
      o.auto_scaling_group.should == 'AUTO-SCALING-GROUP'
      o.group_name.should == 'lll-as-group-dev'
      o.launch_config.should == 'lll-launch-cfg-dev'
      o.availability_zones.should == ['us-east-1d']
      o.created.should == Time.parse('2011-05-06T22:21:54.364Z')
      o.load_balancers.should == []
      o.health_check.should == 'EC2'
      o.min_size.should == 0
      o.max_size.should == 0
      o.desired_capacity.should == 0
      o.default_cooldown.should == 300
      o.grace_period.should == 0
      o.vpc_identifier.should == nil
      o.placement_group.should == nil
      o.group_arn.should == 'arn:aws:autoscali...'
    end

  end

end
