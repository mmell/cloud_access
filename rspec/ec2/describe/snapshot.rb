require File.expand_path(File.dirname(__FILE__) + '/../../ec2')

describe CloudAccess::Ec2::Describe::Snapshot do
  def new_snapshot(aws_data)
    CloudAccess::Ec2::Describe::Snapshot.new(aws_data)
  end
  
  describe "basic accessors" do
    it "knows the values" do
      snap = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
  
      snap.id.should == 'snap-CURRENT'
      snap.volume_id.should == 'vol-41296a2a'
      snap.status.should == 'completed'
      snap.date.should == Time.parse('2010-10-15T06:01:23+0000')
      snap.percent.should == '100%'
      snap.description.should == 'www-dev-10-14'
    end

  end
  
  describe "complete?" do
    it "returns true" do
      snap = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      snap.completed?.should == true
    end

    it "returns false when not completed" do
      snap = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	not-completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      snap.completed?.should == false
    end

    it "returns false when not 100%" do
      snap = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	not-completed	2010-10-15T06:01:23+0000	70%	308696310818	10	www-dev-10-14"
      )
      snap.completed?.should == false
    end
  end

  describe "==" do
    it "returns true" do
      snap1 = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      snap2 = new_snapshot(
        "SNAPSHOT	snap-CURRENT	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      (snap1 == snap2).should == true
    end

    it "returns false" do
      snap1 = new_snapshot(
        "SNAPSHOT	snap-1	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      snap2 = new_snapshot(
        "SNAPSHOT	snap-2	vol-41296a2a	completed	2010-10-15T06:01:23+0000	100%	308696310818	10	www-dev-10-14"
      )
      (snap1 == snap2).should == false
    end

  end

end
