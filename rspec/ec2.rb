require File.expand_path(File.dirname(__FILE__) + '/../lib/cloud_access/ec2')

describe CloudAccess::Ec2 do
  
  describe_volumes = %Q{
VOLUME	vol-72f2621a	2	snap-9f1429f2	us-east-1d	available	2011-02-01T17:31:10+0000											
VOLUME	vol-9d0bfef5	2	snap-ebdca481	us-east-1c	available	2010-11-19T03:32:30+0000											
VOLUME	vol-4557bf2d	2	snap-b9582bd3	us-east-1a	available	2010-11-17T00:37:02+0000											
}


  describe "#rows_from_table?" do
    it "parses" do
      result = CloudAccess::Ec2.rows_from_table(describe_volumes)
      result.is_a?(Array).should == true
      result[1].should == 'VOLUME	vol-9d0bfef5	2	snap-ebdca481	us-east-1c	available	2010-11-19T03:32:30+0000'.strip
    end

  end

end
