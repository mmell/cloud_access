require 'spec_helper'

describe CloudAccess::Ec2::Create::Volume do
  def new_volume(aws_data)
    CloudAccess::Ec2::Create::Volume.new(aws_data)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_volume(
        "VOLUME	vol-eff33c87	500000	snap-41296a2a	us-east-1a	2010-12-08T21:44:06+0000"
      )
  
      o.id.should == 'vol-eff33c87'
      o.size.should == '500000'
      o.snapshot_id.should == 'snap-41296a2a'
      o.zone.should == 'us-east-1a'
      o.timestamp.should == Time.parse('2010-12-08T21:44:06+0000')
    end

  end

end
