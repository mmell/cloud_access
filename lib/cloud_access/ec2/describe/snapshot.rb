require 'time'

module CloudAccess
  module Ec2
    module Describe
  
      class Snapshot
        extend CloudAccess::DynamicAttributes 

        Fields = [ :type, :id, :volume_id, :status, :date, :percent, :undef7, :undef8, :description, :source ]
       
        def initialize(aws_data)
          @data = self.class.parse(aws_data)
#          return nil unless @data[:type] == 'SNAPSHOT'
        end
                
        def is_snapshot?
          (@data[:type] == 'SNAPSHOT')
        end
          
        def completed?
          (status == 'completed' and percent == '100%')
        end
               
        def ==(other)
          id == other.id
        end
        
        # parse the output of an ec2-describe-snapshot system call into a Hash
        #
        def self.parse(s)
          data = Hash[ Fields.zip(s.split(SEP)) ]
          data[:source] = s
          data[:date] = Time.parse(data[:date])
          data
        end

        dynamic_attributes *Fields

      end
    end
  end
end
