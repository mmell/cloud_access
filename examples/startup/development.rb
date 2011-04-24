#!/usr/bin/env ruby

# meant to be called from EC2 User Data. e.g.
#UserData #!/usr/bin/env ruby
#UserData require '/home/ubuntu/startup/development.rb'
#

require File.expand_path(File.dirname(__FILE__) + '/startup')

environment = 'development'
vols = [
  Startup::VolumeDefinition.new('vol-fc7e6c95', '/dev/sdk', '/opt/ebs1', 'ext3')
]

Startup.new(environment, vols)
