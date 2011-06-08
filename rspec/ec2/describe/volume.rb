require File.expand_path(File.dirname(__FILE__) + '/../../../lib/cloud_access/ec2')

describe CloudAccess::Ec2::Describe::Volume do
  def new_volume(aws_data)
    CloudAccess::Ec2::Describe::Volume.new(aws_data)
  end
  
  describe "basic accessors" do
    it "knows the values" do
      vol = new_volume(
        "VOLUME	vol-eff33c87	5		us-east-1a	in-use	2010-12-08T21:44:06+0000	ATTACHMENT	vol-eff33c87	i-10499c7f	/dev/sdh	attached	2011-03-24T17:21:29+0000	TAG	volume	vol-eff33c87	Name	trac"
      )
  
      vol.id.should == 'vol-eff33c87'
      vol.snap_id.should == ''
      vol.region.should == 'us-east-1a'
      vol.state.should == 'in-use'
      vol.date.should == Time.parse('2010-12-08T21:44:06+0000')
      vol.tag.should == 'TAG'
      vol.tag_value.should == 'volume'
      vol.name.should == 'Name'
      vol.name_value.should == 'trac'
    end

  end

  describe "#in_use?" do
    it "returns true" do
      vol = new_volume(
        "VOLUME	vol-8fdfe8e7	2	snap-0b6c2367	us-east-1d	in-use	2011-03-24T08:50:23+0000	ATTACHMENT	vol-8fdfe8e7	i-70d51f1f	/dev/sdf	attached	2011-03-24T08:50:32+0000"
      )
  
      vol.in_use?.should == true
    end

    it "returns false" do
      vol = new_volume(
        "VOLUME	vol-8fdfe8e7	2	snap-0b6c2367	us-east-1d	available	2011-03-24T08:50:23+0000	ATTACHMENT	vol-8fdfe8e7	i-70d51f1f	/dev/sdf	attached	2011-03-24T08:50:32+0000"
      )
      vol.in_use?.should == false
    end
  end

  describe "#is_tagged?" do
    it "returns true" do
      vol = new_volume(
        "VOLUME	vol-2178bd49	5		us-east-1d	available	2010-12-02T21:22:58+0000							TAG	volume	vol-2178bd49	Name	splunk"
      )
      vol.is_tagged?.should == true
    end

    it "returns false" do
      vol = new_volume(
        "VOLUME	vol-dbef12b3	2	snap-db5e0eb1	us-east-1d	available	2010-11-25T00:10:49+0000"
      )
      vol.is_tagged?.should == false
    end
  end

end
