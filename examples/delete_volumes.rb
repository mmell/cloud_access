#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../ec2/volumes')

CloudAccess::Ec2::Describe::Volumes.delete_all_available
