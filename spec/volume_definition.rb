require 'spec_helper'

describe CloudAccess::VolumeDefinition do

  def new_volume_definition
    CloudAccess::VolumeDefinition.new(
      :volume_id => 'vol-efec1484', 
      :fs_type => 'ext3', 
      :mount_point => '/opt/ebs1', 
      :attachment_device => '/dev/sdk', 
      :mount_device => '/dev/xvdk', 
      :mount_original => true
    )
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_volume_definition
  
      o.volume_id.should == 'vol-efec1484'
      o.fs_type.should == 'ext3'
      o.mount_point.should == '/opt/ebs1'
      o.attachment_device.should == '/dev/sdk'
      o.mount_device.should == o.attachment_device # or when is_natty? == '/dev/xvdk'
      o.mount_original.should == true
    end

  end

end
