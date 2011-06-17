module CloudAccess
  module As
    module Describe
  
      class AutoScalingGroups < Array

        def initialize(aws_data)
          super(
            CloudAccess::As.parse_csv(aws_data).map { |e| 
              AutoScalingGroup.new(e) 
            }.delete_if { |e| 
              !e.is_auto_scaling_group? 
            }
          )
        end
          
        def self.describe( shell_args = '' )
          new( %x[ as-describe-auto-scaling-groups #{shell_args} --show-empty-fields --show-long ] )
        end

      end
    end
  end
end
