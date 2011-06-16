module CloudAccess
  module As
    module Delete
  
      class LaunchConfig
        include CloudAccess::As::Base 

        def initialize(response)
          @response = response
        end

        def self.as_delete_launch_config(name)
          new( %x[ as-delete-launch-config --force #{name} ] )
        end

      end
    end
  end
end
