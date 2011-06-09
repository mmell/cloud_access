require 'cloud_access/dynamic_attributes.rb'
require 'cloud_access/ec2/associate'
require 'cloud_access/ec2/attach'
require 'cloud_access/ec2/create'
require 'cloud_access/ec2/describe'

module CloudAccess
  module Ec2

    SEP = "\t"
  
    def Ec2.rows_from_table(t) # AWS calls a csv stream a "table"
      t.strip.split("\n").map { |e| e.strip }
    end
    
    # thanks http://www.cloudiquity.com/2009/02/finding-information-about-an-amazon-ec2-instance/
    def Ec2.my_instance_id
      %x[wget -qO- http://169.254.169.254/1.0/meta-data/instance-id]
    end
    
  end
  
end
