require 'cloud_access/as/describe/launch_config'

module CloudAccess
  module As
    module Describe
  
      class LaunchConfigs < Array

        def initialize(aws_data)
          super(
            CloudAccess::As.parse_csv(aws_data).map { |e| 
              LaunchConfig.new(e) 
            }
          )
        end
          
        def self.as_describe_launch_config( shell_args = '' )
          new( %x[ as-describe-launch-configs #{shell_args} --show-empty-fields --show-long ] )
        end

      end
    end
  end
end
