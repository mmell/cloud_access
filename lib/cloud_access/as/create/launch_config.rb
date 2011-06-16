module CloudAccess
  module As
    module Create
  
      class LaunchConfig
        include CloudAccess::As::Base 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'vol-4d826724'
        #
#        Fields = [ 
#          :name, :image_id, :instance_type, :block_device_mapping, :monitoring_enabled, 
#          :monitoring_disabled, :kernel, :key, :ramdisk, :group, :user_data, :user_data_file
#        ] + CloudAccess::As::GeneralOptionFields
        
        def initialize(response)
          @response = response
        end
        
        # make the ec2-attach-volume system call
        # returns a string corresponding to Fields
        #
        def self.as_create_launch_config(shell_args)
          new( %x[ as-create-launch-config #{shell_args} ] )
        end

      end
    end
  end
end
