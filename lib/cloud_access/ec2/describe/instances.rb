module CloudAccess
  module Ec2
    module Describe
  
      class Instances < Array

        # create an object that reflects the results of the system call
        #
        def initialize(aws_data)
          super(
            CloudAccess::Ec2.rows_from_table(aws_data).map { |e| 
              Instance.new(e) 
            }.delete_if { |e| 
              !e.is_instance? 
            }
          )
        end
        
        # make the system call and return a new object
        #
        def self.ec2_describe_instances(opts = '')
          new( %x[ec2-describe-instances #{opts}] )
        end

        def self.ec2_describe_instance(instance_id)
          ec2_describe_instances( instance_id ).first
        end

      end
    end
  end
end
