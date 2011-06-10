require 'time'

module CloudAccess
  module Ec2
    module Attach
  
      class Volume
        extend CloudAccess::DynamicAttributes 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'vol-4d826724'
        #
        Fields = [ :type, :id, :instance_id, :device, :state, :timestamp, :source ]
        
        # call ec2-attach-volume and create an object that reflects the results
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          raise RuntimeError, aws_data unless @data[:type] == 'ATTACHMENT'
        end
        
        def is_attachment?
          (@data[:type] == 'ATTACHMENT')
        end
          
        # make the ec2-attach-volume system call
        # returns a string corresponding to Fields
        #
        def self.ec2_attach_volume(volume_id, instance_id, device)
          new( %x[ec2-attach-volume #{volume_id} --instance #{instance_id} --device #{device}] )
        end

        # parse the output of an ec2-attach-volume system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data[:timestamp] = Time.parse(data[:timestamp]) if data[:timestamp]
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
