module CloudAccess
  module Ec2
    module Associate
  
      # http://docs.amazonwebservices.com/AWSEC2/latest/CommandLineReference/index.html?ApiReference-cmd-AssociateAddress.html
      #
      class Address
        extend CloudAccess::DynamicAttributes 
        
        # field values are accessible as self.<field_name>, e.g. self.id => 'vol-4d826724'
        #
        Fields = [ :type, :elastic_ip, :instance_id, :association_id ]
        
        # call ec2-attach-volume and create an object that reflects the results
        #
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          raise RuntimeError, aws_data unless @data[:type] == 'ADDRESS'
        end
        
        def is_attachment?
          (@data[:type] == 'ATTACHMENT')
        end
          
        # make the ec2-attach-volume system call
        # returns a string corresponding to Fields
        #
        def self.ec2_associate_address(instance_id, ip_address = nil, allocation_id = nil)
          ip_or_allocation_id = ( ip_address.nil? ? "-a #{allocation_id}" : ip_address)
          new( %x[ec2-associate-address -i #{instance_id} #{ip_or_allocation_id}] )
        end

        # parse the output of an ec2-attach-volume system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
