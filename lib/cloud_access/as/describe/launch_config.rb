require 'time'

module CloudAccess
  module As
    module Describe
  
      class LaunchConfig
        extend CloudAccess::DynamicAttributes 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'vol-4d826724'
        #
        Fields = [ 
          :launch_config, :name, :image_id, :instance_type, :key, :kernel_id, :ramdisk_id, :device_map, :sg, :created, :moniotring, :launch_config_arn
        ] 
        
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
        end

        def monitoring
          @data[:moniotring]
        end
        
        # parse the output of an as-describe-launch-config system call into a Hash
        # accept an array since As uses As.parse_csv(csv) to parse results
        #
        def self.parse(row_array)
          data = Hash[ Fields.zip(row_array) ]
          data[:source] = row_array
          data[:created] = Time.parse(data[:created]) if data[:created]
          data[:sg] = [ data[:sg] ] unless data[:sg].is_a?(Array)
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
