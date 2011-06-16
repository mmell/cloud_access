require 'spec_helper'

describe CloudAccess::As::Describe::LaunchConfig do
  # :launch_config, :name, :image_id, :instance_type, :key, :kernel_id, :ramdisk_id, :device_map, :sg, :created, :moniotring, :launch_config_arn
  
  def new_instance(aws_data)
    arr = CloudAccess::As.parse_csv(aws_data)[0]
    CloudAccess::As::Describe::LaunchConfig.new(arr)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_instance( 'LAUNCH-CONFIG,lll-launch-cfg-dev,ami-5ac23d33,m1.large,(nil),(nil),(nil),(nil),"Memcached,Public,Root Access,default",2011-05-06T22:21:03.921Z,true,arn:aws:autoscaling:us-east-1:638756973923:launchConfiguration:0301e6b4-2b1f-4b15-a62f-59f88afc5070:launchConfigurationName/lll-launch-cfg-dev' )
  
      o.launch_config.should == 'LAUNCH-CONFIG'
      o.name.should == 'lll-launch-cfg-dev'
      o.image_id.should == 'ami-5ac23d33'
      o.instance_type.should == 'm1.large'
      o.key.should == nil
      o.kernel_id.should == nil
      o.ramdisk_id.should == nil
      o.device_map.should == nil
      o.sg.should == ['Memcached','Public','Root Access','default']
      o.created.should == Time.parse('2011-05-06T22:21:03.921Z')
    end

  end

end
