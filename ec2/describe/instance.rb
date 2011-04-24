#!/usr/bin/env ruby

require 'time'

module CloudAccess
  module Ec2
    module Describe
  
      class Instance
        extend CloudAccess::DynamicAttributes 
        
        # fields are accessible as obj.field_name, e.g. obj.id => 'vol-4d826724'
        #
        Fields = [ 
          :type, :instance_id, :ami_id, 
          :public_dns, :private_dns, :instance_state, :key_name, :launch_index, :undef, :product_codes,
          :launch_time, :availability_zone, :kernel_id, :undef, :undef, :monitoring_state, :public_ip, :private_ip, 
          :tenancy, :subnet_id, :vpc_id, :root_device_type, :placement_group, :virtualization_type, :security_group_ids, 
          :tags, :hypervisor, :blockdevice_id, :source
        ]
# INSTANCE\ti-48603227\tami-da679bb3\tec2-50-17-246-0.compute-1.amazonaws.com\tip-10-83-42-165.ec2.internal\trunning\t\t0\t\tm1.large\t2011-04-23T20:56:07+0000
#\tus-east-1d\taki-427d952b\t\t\tmonitoring-disabled\t50.17.246.0\t10.83.42.165\t\t\tebs\t\t\t\t\tparavirtual\txen\t
#\tsg-8c9fffe5, sg-e5bf5e8c, sg-3ee08057, sg-0a7f1163\tdefault

        # create an object that reflects the results of the system call
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
        end
        
        def is_instance?
          (@data[:type] == 'INSTANCE')
        end
          
        # parse the output of a system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data[:launch_time] = Time.parse(data[:launch_time]) if data[:launch_time]
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
