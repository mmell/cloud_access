require 'spec_helper'

describe CloudAccess::ShellArgs do

  describe "initialization" do

    it "is empty" do
      o = CloudAccess::ShellArgs.new
      o.empty?.should == true
    end

    it "is has items" do
      o = CloudAccess::ShellArgs.new('aoeu', 2)
      o.empty?.should == false
      o[0].should == 'aoeu'
      o[1].should == 2
    end

  end

  describe "append" do

    it "appends" do
      o = CloudAccess::ShellArgs.new('aoeu', 2)
      o << 4
      o[0].should == 'aoeu'
      o[1].should == 2
      o[2].should == 4
    end

  end

  describe "to_s" do

    it "is has items" do
      o = CloudAccess::ShellArgs.new('aoeu', 2)
      o.to_s.should == 'aoeu 2'
    end

    it "retains order of appends" do
      o = CloudAccess::ShellArgs.new('aoeu', 2)
      o << 5
      o.to_s.should == 'aoeu 2 5'
    end

    it "handles switches" do
      o = CloudAccess::ShellArgs.new('aoeu', 2, '--instance-id ami-1234snth')
      o.to_s.should == 'aoeu 2 --instance-id ami-1234snth'
    end

    it "handles lists" do
      o = CloudAccess::ShellArgs.new('aoeu')
      o << '-g group1,group2'
      o.to_s.should == 'aoeu -g group1,group2'
    end

  end

end
