#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/dynamic_attributes')
require File.expand_path(File.dirname(__FILE__) + '/ec2/attach')
require File.expand_path(File.dirname(__FILE__) + '/ec2/create')
require File.expand_path(File.dirname(__FILE__) + '/ec2/describe')

module CloudAccess
  module Ec2

    SEP = "\t"
  
    def Ec2.rows_from_table(t) # AWS calls a csv stream a "table"
      t.strip.split("\n").map { |e| e.strip }
    end
    
    # thanks http://www.cloudiquity.com/2009/02/finding-information-about-an-amazon-ec2-instance/
    def Ec2.instance_id
      %x[wget http://169.254.169.254/1.0/meta-data/instance-id]
    end
    
  end
  
end
