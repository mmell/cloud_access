module CloudAccess
  module As
    module Create
  
      class LaunchConfig
        include CloudAccess::As::Base 
        
        def initialize(response)
          @response = response
        end
           
        def self.create(shell_args)
          new( %x[ as-create-launch-config #{shell_args} ] )
        end

      end
    end
  end
end
