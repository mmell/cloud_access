require 'spec_helper'

describe CloudAccess::As::Describe::LaunchConfigs do
  
  aws_data = %Q{LAUNCH-CONFIG,LC1,ami-5ac23d33,m1.large,(nil),(nil),(nil),(nil),"one,two,three",2011-05-06T22:21:03.921Z,true,arn:aws:1...
LAUNCH-CONFIG,LC2,ami-5ac23d33,m1.large,(nil),(nil),(nil),(nil),"one,two,three",2011-05-06T22:21:03.921Z,true,arn:aws:2...
LAUNCH-CONFIG,LC3,ami-5ac23d33,m1.large,(nil),(nil),(nil),(nil),"one,two,three",2011-05-06T22:21:03.921Z,true,arn:aws:3...}
  
  def new_instance(aws_data)
    CloudAccess::As::Describe::LaunchConfigs.new(aws_data)
  end
  
  describe "initialization" do
    it "creates its array" do
      o = new_instance( aws_data )
      oo = o[0]
      
      oo.launch_config.should == 'LAUNCH-CONFIG'
      oo.name.should == 'LC1'
      oo.image_id.should == 'ami-5ac23d33'
      oo.instance_type.should == 'm1.large'
      oo.key.should == nil
      oo.kernel_id.should == nil
      oo.ramdisk_id.should == nil
      oo.device_map.should == nil
      oo.sg.should == ['one', 'two', 'three']
      oo.created.should == Time.parse('2011-05-06T22:21:03.921Z')
    end

  end

  describe "handles empty respone" do
    it "is not launch_config" do
      o = new_instance( 'BLAH,lll-launch-cfg-dev,ami-5ac23d33,m1.large,(nil),(nil),(nil),(nil),"Memcached,Public,Root Access,default",2011-05-06T22:21:03.921Z,true,arn:aws:autoscaling...' )
  
      o.empty?.should == true
    end
    
    it "does not crash on empty response" do
      o = new_instance( 'No launch configurations found' )
  
      o.empty?.should == true
    end

  end

end
