require 'cloud_access/system'

module CloudAccess
  class VolumeDefinition
    
    Fields = [:volume_id, :name, :fs_type, :mount_point, :attachment_device, :mount_device, :mount_original]
    
    def initialize(opts = {})
      @data = opts
    end
    
    def system
      @system ||= CloudAccess::System.new
    end
    
    # ubuntu 11.04, when told to attach to /dev/sdk creates a device at /dev/xvdk
    #   so we track both and use appropriately
    #
    def mount_device
      ((system.is_natty? and attachment_device) ? @data[:mount_device] : attachment_device )
    end
    
    def self.dynamic_attributes
      Fields.each { |e|
        next if e == :mount_device
        define_method e do
          @data[e]
        end
      }
    end
    
    dynamic_attributes
    
  end
end
