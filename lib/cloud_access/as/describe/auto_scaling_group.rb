require 'time'

module CloudAccess
  module As
    module Describe
  
      class AutoScalingGroup
        extend CloudAccess::DynamicAttributes 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'vol-4d826724'
        #
        Fields = [ 
          :auto_scaling_group, :group_name, :launch_config, :availability_zones, :created, :load_balancers, :health_check, :min_size, :max_size, :desired_capacity, :default_cooldown, :grace_period, :vpc_identifier, :placement_group, :group_arn
        ] 
        
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
        end
        
        def is_auto_scaling_group?
          @data[:auto_scaling_group] == 'AUTO-SCALING-GROUP'
        end
        
        # parse the output of an as-describe-launch-config system call into a Hash
        # accept an array since As uses As.parse_csv(csv) to parse results
        #
        def self.parse(row_array)
          data = Hash[ Fields.zip(row_array) ]
          return data unless data[:auto_scaling_group] == 'AUTO-SCALING-GROUP'
          data[:source] = row_array
          data[:availability_zones] = [ data[:availability_zones] ] unless data[:availability_zones].is_a?(Array)
          unless data[:load_balancers].is_a?(Array)
            data[:load_balancers] = (data[:load_balancers].nil? ? [] : [ data[:load_balancers] ] )
          end
          data[:created] = Time.parse(data[:created]) if data[:created]          
          [:min_size, :max_size, :desired_capacity, :default_cooldown, :grace_period].each { |e|
            data[e] = data[e].to_i if data[e]
          }
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
