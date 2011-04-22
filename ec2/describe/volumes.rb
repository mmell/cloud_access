#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../describe')

module CloudAccess
  module Ec2
    module Describe
    
      class Volumes
        DEBUG = false
        
        attr_reader :volumes
        
        def initialize(aws_data)
          @volumes = CloudAccess::Ec2.rows_from_table(aws_data).map { |e| 
            Volume.new(e) 
          }.delete_if { |e| 
              e.nil? 
          }
          raise RuntimeError, "No Volumes found." if @volumes.empty?
        end
        
        def delete_volumes
          @volumes.each { |vol| 
            if allow_delete?(vol)
              CloudAccess::Ec2::Snapshots.delete_all_of_volume(vol.id)
              puts "ec2-delete-volume #{vol.id}"
              if DEBUG
                puts '(disabled)'
              else
                %x[ec2-delete-volume #{vol.id}]
              end
            else
              puts "not deleting #{vol.id}"
            end
          }
        end  
  
        def allow_delete?(vol)
          !(vol.in_use? or vol.is_tagged?)
        end
        
        def self.delete_all_available # ENHANCEMENT: we could accept a list of non-attached volumes to preserve here
          puts "Deleting all volumes (and all of its snapshots) that are not attached to running instances (status: available)."
          puts "Please confirm that *all systems are up and running* ... (y/n)"
          raise RuntimeError, "Aborted" unless gets.chomp[0].downcase == 'y'
  
          # For filter options, see 
          #   http://docs.amazonwebservices.com/AWSEC2/latest/CommandLineReference/index.html?ApiReference-cmd-DescribeVolumes.html
          aws_data = %x[ec2-describe-volumes --filter status=available] # returns nothing: --filter attachment.status=detached
          CloudAccess::Ec2::Describe::Volumes.new(aws_data).delete_volumes
        end
        
      end
    end
  end
end
