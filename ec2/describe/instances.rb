#!/usr/bin/env ruby

module CloudAccess
  module Ec2
    module Describe
  
      class Instances < Array

        # call ec2-attach-volume and create an object that reflects the results
        #
        def initialize(aws_data)
          super (
            CloudAccess::Ec2.rows_from_table(aws_data).map { |e| 
              Instance.new(e) 
            }
          )
        end
        
        # make the ec2-describe-instances system call
        # returns a string corresponding to Fields
        #
        def self.ec2_describe_instances(opts = '')
          new( %x[ec2-describe-instances #{opts}] )
        end

      end
    end
  end
end
