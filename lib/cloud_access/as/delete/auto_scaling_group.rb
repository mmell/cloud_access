module CloudAccess
  module As
    module Delete
  
      class AutoScalingGroup
        include CloudAccess::As::Base 

        def initialize(response)
          @response = response
        end

        def self.delete(shell_args)
          new( %x[ as-delete-auto-scaling-group --force #{shell_args} ] )
        end

      end
    end
  end
end
