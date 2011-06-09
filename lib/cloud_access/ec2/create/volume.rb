require 'time'

module CloudAccess
  module Ec2
    module Create
  
      class Volume
        extend CloudAccess::DynamicAttributes 
        
        # fields are accessible as obj.field_name, e.g. obj.id => 'vol-4d826724'
        #
        Fields = [ :type, :id, :size, :snapshot_id, :zone, :timestamp, :source ]
        
        # call ec2-create-volume and create an object that reflects the results
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          raise RuntimeError, aws_data unless @data[:type] == 'VOLUME'
        end
        
        def is_volume?
          (@data[:type] == 'VOLUME')
        end
          
        # make the ec2-attach-volume system call
        # returns a string corresponding to Fields
        #
        def self.ec2_create_volume(snapshot_id, availability_zone)
          new( %x[ec2-create-volume --snapshot #{snapshot_id} --availability-zone #{availability_zone}] )
        end

        # parse the output of an ec2-attach-volume system call into a Hash
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
