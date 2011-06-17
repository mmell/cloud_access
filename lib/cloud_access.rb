require 'cloud_access/dynamic_attributes.rb'
require 'cloud_access/as.rb'
require 'cloud_access/ec2.rb'
require 'cloud_access/shell_args.rb'
require 'cloud_access/system.rb'
require 'cloud_access/version.rb'
require 'cloud_access/volume_definition.rb'

module CloudAccess

  def CloudAccess.rows_from_table(t) # AWS calls a csv stream a "table"
    t.strip.split("\n").map { |e| e.strip }
  end
  
end
