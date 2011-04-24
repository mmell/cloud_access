#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/cloud_access/ec2')

class Startup
  
  VolumeDefinition = Struct.new(:volume_id, :device, :mount_point, :fs_type)
  DEBUG = true
  
  def initialize(environment, volumes)
    @environment = environment
    @logger = Logger.new(@environment)
    logger.debug "@environment #{@environment}"

    @instance = CloudAccess::Ec2::Describe::Instances.ec2_describe_instance( CloudAccess::Ec2.my_instance_id )
    logger.debug "@instance #{@instance.instance_id}"
    
    volumes.each { |volume_definition| 
      volume_id = volume_id_for_mounting(volume_definition.volume_id)
      logger.debug "volume_id #{volume_id}"
      attach_volume(volume_id, volume_definition.device)
      mount_volume(volume_definition)
    }
  end
  
  def logger
    @logger
  end
  
  def mount_volume(volume_definition)
    fs = (volume_definition.fs_type.nil? ? "" : "-t #{volume_definition.fs_type}")
    logger.debug "mounting: #{fs} #{volume_definition.device} #{volume_definition.mount_point}"
    logger.debug %x[sudo mount #{fs} #{volume_definition.device} #{volume_definition.mount_point}]
  end
  
  def attach_volume(volume_id, device)
    attachment = CloudAccess::Ec2::Attach::Volume.ec2_attach_volume(volume_id, @instance.instance_id, device)

    while (volume = CloudAccess::Ec2::Describe::Volumes.ec2_describe_volume(volume_id))
      break if volume.in_use?
      logger.debug "waiting for  volume #{volume_id} to become attached (#{volume.state} #{volume.source})..."
      sleep 3
    end
    attachment
  end
  
  def volume_id_for_mounting(src_volume_id)
    if @environment == 'development'
      volume = CloudAccess::Ec2::Describe::Volumes.ec2_describe_volume(src_volume_id)
      return src_volume_id if volume.available?
    end
    
    snapshot_id = CloudAccess::Ec2::Describe::Snapshots.current_snapshot_id(src_volume_id)
    create_volume = CloudAccess::Ec2::Create::Volume.ec2_create_volume(snapshot_id, @instance.availability_zone)
    while (volume = CloudAccess::Ec2::Describe::Volumes.ec2_describe_volume(create_volume.id))
      break if volume.available?
      logger.debug "waiting for new volume #{create_volume.id} to become available..."
      sleep 3
    end

    create_volume.id
  end
end

class Logger
  # FIXME: use the standard methods
  def initialize(@environment)
    @environment = environment
  end
  
  def error(s)
    puts s
  end
  
  def info(s)
    puts s
  end
  
  def debug(s)
    puts s if @environment == 'development'
  end
  
end

# copies the correct nginx config for the env
# starts the correct thin rails servers
