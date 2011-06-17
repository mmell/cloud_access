module CloudAccess
  module As
    module Delete
  
      class LaunchConfig
        include CloudAccess::As::Base 

        def initialize(response)
          @response = response
        end

        def self.delete(shell_args)
          new( %x[ as-delete-launch-config --force #{shell_args} ] )
        end

      end
    end
  end
end
