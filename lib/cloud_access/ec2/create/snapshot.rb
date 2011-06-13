require 'time'

module CloudAccess
  module Ec2
    module Create
  
      class Snapshot
        extend CloudAccess::DynamicAttributes 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'snap-c070c5a9'
        #
        Fields = [ :type, :id, :volume_id, :state, :timestamp, :owner_id, :size, :description, :source ]
        
        # call ec2-create-snapshot and create an object that reflects the results
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          raise RuntimeError, aws_data unless @data[:type] == 'VOLUME'
        end
        
        def is_snapshot?
          (@data[:type] == 'SNAPSHOT')
        end
          
        # make the ec2-attach-snapshot system call
        # returns a string corresponding to Fields
        #
        def self.ec2_create_snapshot(volume_id, description = '')
          new( %x[ec2-create-snapshot #{volume_id} --description '#{description}'] )
        end

        # parse the output of an ec2-attach-snapshot system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data[:timestamp] = Time.parse(data[:timestamp])
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
