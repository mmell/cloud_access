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
          :public_dns, :private_dns, :instance_state, :key_name, :launch_index, :product_codes, 
          :launch_time, :availability_zone, :kernel_id, :ram_disk_id, :monitoring_state, :public_ip, :private_ip, 
          :tenancy, :subnet_id, :vpc_id, :root_device_type, :placement_group, :virtualization_type, :security_group_ids, 
          :tags, :hypervisor, :blockdevice_id
        ]
        
        # create an object that reflects the results of the system call
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
        end
        
        # parse the output of a system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:launch_time] = Time.parse(data[:launch_time])
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
