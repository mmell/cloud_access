require File.expand_path(File.dirname(__FILE__) + '/../../ec2')

describe CloudAccess::Ec2::Describe::Snapshots do
  describe "#current_snapshot" do
    it "returns the latest" do
      
      describe_snapshots = %Q{SNAPSHOT	snap-15d87e7e	vol-cd2968a6	completed	2010-10-14T02:38:32+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-1805555d from vol-cd2968a6
SNAPSHOT	snap-5121853a	vol-812160ea	completed	2010-10-13T04:38:53+0000	100%	308696310818	10	
SNAPSHOT	snap-858f29ee	vol-41296a2a	completed	2010-10-14T05:19:56+0000	100%	308696310818	10	Created by CreateImage(i-492e840d) for ami-c4055581 from vol-41296a2a
SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.current_snapshot('vol-41296a2a').id.should == 'snap-CURRENT'
    end
  end

  describe "allow_delete?" do
    it "returns true" do
      describe_snapshots = %Q{
SNAPSHOT	snap-15d87e7e	vol-cd2968a6	completed	2010-10-12T02:38:32+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-1805555d from vol-cd2968a6
SNAPSHOT	snap-2	vol-812160ea	completed	2010-10-13T04:38:53+0000	90%	308696310818	10	
SNAPSHOT	snap-5121853a	vol-812160ea	completed	2010-10-13T04:38:53+0000	100%	308696310818	10	
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6
}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.is_current_snapshot?(s[0]).should == false
      s.allow_delete?(s[0]).should == true
    end

    it "returns false when not completed" do
      describe_snapshots = %Q{
SNAPSHOT	snap-15d87e7e	vol-cd2968a6	NOTcompleted	2010-10-14T02:38:32+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-1805555d from vol-cd2968a6
SNAPSHOT	snap-2	vol-812160ea	completed	2010-10-13T04:38:53+0000	90%	308696310818	10	
SNAPSHOT	snap-5121853a	vol-812160ea	completed	2010-10-13T04:38:53+0000	100%	308696310818	10	
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6
}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.allow_delete?(s[0]).should == false
    end

    it "returns false when is_current_snapshot?" do
      describe_snapshots = %Q{SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.allow_delete?(s[0]).should == false
    end
  end

  describe "is_current_snapshot?" do
    it "returns true" do
      describe_snapshots = %Q{SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.is_current_snapshot?(s[0]).should == true
    end

    it "ignores the row when not completed" do
      describe_snapshots = %Q{
SNAPSHOT	snap-15d87e7e	vol-cd2968a6	NOTcompleted	2010-10-14T02:38:32+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-1805555d from vol-cd2968a6
SNAPSHOT	snap-2	vol-812160ea	completed	2010-10-13T04:38:53+0000	90%	308696310818	10	
SNAPSHOT	snap-3	vol-812160ea	completed	2010-10-13T04:38:53+0000	100%	308696310818	10	
SNAPSHOT	snap-f1e84e9a	vol-cd2968a6	completed	2010-10-13T23:18:52+0000	100%	308696310818	10	Created by CreateImage(i-9fde74db) for ami-5a05551f from vol-cd2968a6
}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s[0].id.should == 'snap-3'
    end

  end

  describe "equals" do
    it "returns true" do
      describe_snapshots = %Q{
SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14
SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14
}

      s = CloudAccess::Ec2::Describe::Snapshots.new(describe_snapshots)
      CloudAccess::Ec2::Describe::Snapshots.stub(:create_by_volume_id) { s.dup }
      s.is_current_snapshot?(s[0]).should == true
    end

  end

end
