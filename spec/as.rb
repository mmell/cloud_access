require 'spec_helper'

describe CloudAccess::As do

  describe "parse_csv" do
    
    it "parses a line" do
      aws_data = %Q{line1,true,(nil)}
      parsed = CloudAccess::As.parse_csv(aws_data)
      parsed.size.should == 1
      parsed[0].size.should == 3
      parsed[0][0].should == 'line1'
      parsed[0][1].should == true
      parsed[0][2].should == nil

    end
    
    it "parses booleans, nils and arrays" do
      aws_data = %Q{line1,true,false,(nil),"one,two"}
      parsed = CloudAccess::As.parse_csv(aws_data)
      parsed[0][0].should == 'line1'
      parsed[0][1].should == true
      parsed[0][2].should == false
      parsed[0][3].should == nil
      parsed[0][4].should == ['one', 'two']
    end
    
    it "parses more lines" do
      aws_data = %Q{line1,(nil)
line2,"1,2"}
      parsed = CloudAccess::As.parse_csv(aws_data)
      parsed.size.should == 2
      parsed[0].size.should == 2
      parsed[1].size.should == 2

      parsed[0][0].should == 'line1'
      parsed[0][1].should == nil

      parsed[1][0].should == 'line2'
      parsed[1][1].should == ['1', '2']
    end
    
  end

end
