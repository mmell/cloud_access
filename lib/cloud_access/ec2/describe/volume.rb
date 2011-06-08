#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../describe')

module CloudAccess
  module Ec2
    module Describe
  
      class Volume
        extend CloudAccess::DynamicAttributes 

        Fields = [ :type, :id, :undef2, :snap_id, :region, :state, :date, :undef7, :undef8, :undef9, 
          :undef10, :undef11, :undef12, :tag, :tag_value, :undef15, :name, :name_value, :source
        ]
                
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          raise RuntimeError, aws_data unless @data[:type] == 'VOLUME' # FIXME: maybe it's an Attach::Volume row?
        end
          
        def is_volume?
          (@data[:type] == 'VOLUME')
        end
          
        def available?
          (state == 'available')
        end
          
        def in_use?
          (state == 'in-use')
        end

        def is_tagged?
          (tag == 'TAG' and name == 'Name')
        end
        
        def snapshots
          CloudAccess::Ec2::Snapshots.snapshots_of_volume(id)
        end
        
        # parse the output of an ec2-describe-volume system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data[:date] = Time.parse(data[:date]) if data[:date]
          data
        end

        dynamic_attributes *Fields
  
      end
    end
  end
end
