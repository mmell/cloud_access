module CloudAccess
  module As
    module Create
  
      class AutoScalingGroup
        include CloudAccess::As::Base 
        
        def initialize(response)
          @response = response
        end
           
        def self.as_create_auto_scaling_group(shell_args)
          new( %x[ as-create-auto-scaling-group #{shell_args} ] )
        end

      end
    end
  end
end
