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
    
  end
  
end
