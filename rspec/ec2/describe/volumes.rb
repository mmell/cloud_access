require File.expand_path(File.dirname(__FILE__) + '/../../ec2')

describe CloudAccess::Ec2::Describe::Volume do
  def new_volumes(describe_volumes)
    CloudAccess::Ec2::Describe::Volumes.new(describe_volumes)
  end
  
  describe_volumes = %Q{VOLUME	vol-8fdfe8e7	2	snap-0b6c2367	us-east-1d	in-use	2011-03-24T08:50:23+0000	ATTACHMENT	vol-8fdfe8e7	i-70d51f1f	/dev/sdf	attached	2011-03-24T08:50:32+0000					
VOLUME	vol-efd93387	2	snap-61245a0b	us-east-1d	available	2010-11-18T04:16:11+0000											
VOLUME	vol-72f2621a	2	snap-9f1429f2	us-east-1d	available	2011-02-01T17:31:10+0000											
VOLUME	vol-887a7be1	15	snap-07b8496d	us-east-1a	available	2010-10-13T21:31:11+0000											
VOLUME	vol-60c41808	2	snap-55cc3c38	us-east-1d	available	2010-12-18T08:00:10+0000											
VOLUME	vol-9d0bfef5	2	snap-ebdca481	us-east-1c	available	2010-11-19T03:32:30+0000											
VOLUME	vol-4557bf2d	2	snap-b9582bd3	us-east-1a	available	2010-11-17T00:37:02+0000											
VOLUME	vol-7a1d1012	2	snap-da2a28b6	us-east-1d	available	2011-04-02T01:44:54+0000											
VOLUME	vol-dbef12b3	2	snap-db5e0eb1	us-east-1d	available	2010-11-25T00:10:49+0000											
VOLUME	vol-2178bd49	5		us-east-1d	available	2010-12-02T21:22:58+0000							TAG	volume	vol-2178bd49	Name	splunk
VOLUME	vol-f2ff919a	2	snap-c615e3aa	us-east-1d	available	2011-02-15T03:05:27+0000											
VOLUME	vol-eff33c87	5		us-east-1a	in-use	2010-12-08T21:44:06+0000	ATTACHMENT	vol-eff33c87	i-10499c7f	/dev/sdh	attached	2011-03-24T17:21:29+0000	TAG	volume	vol-eff33c87	Name	trac}


  describe "#allow_delete?" do
    it "allows delete" do
      vols = new_volumes(describe_volumes)
      vols.allow_delete?(vols[1]).should == true
    end

    it "does not allow delete" do
      vols = new_volumes(describe_volumes)
      vols.allow_delete?(vols[0]).should == false
    end

  end

end
