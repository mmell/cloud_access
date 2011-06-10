require 'spec_helper'

describe CloudAccess::Ec2::Create::Snapshot do
  def new_snapshot(aws_data)
    CloudAccess::Ec2::Create::Snapshot.new(aws_data)
  end
  
  describe "basic accessors" do
    it "parses the field values" do
      o = new_snapshot(
        "SNAPSHOT	snap-c070c5a9	vol-9539dcfc	pending	2009-09-16T14:31:29+0000	999988887777	1	Daily Backup"
      )
  
      o.id.should == 'snap-c070c5a9'
      o.volume_id.should == 'vol-9539dcfc'
      o.state.should == 'pending'
      o.timestamp.should == Time.parse('2009-09-16T14:31:29+0000')
      o.owner_id.should == '999988887777'
      o.size.should == '1'
      o.description.should == 'Daily Backup'
    end

  end

end
