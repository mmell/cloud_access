#!/usr/bin/env ruby

require 'time'
require File.expand_path(File.dirname(__FILE__) + '/../describe')

module CloudAccess
  module Ec2
  module Describe

    class Snapshots < Array
      DEBUG = false
      
      def initialize(aws_data, opts = {})
        super( 
          CloudAccess::Ec2.rows_from_table(aws_data).map { |e| 
            Snapshot.new(e) 
          }.delete_if { |e| 
            !e.is_snapshot? or !e.completed?
          }
        )
        @opts = opts
      end
      
      def current_snapshot(volume_id)
        return @latest[volume_id] if @latest and @latest[volume_id]
        @latest ||= {}
        Snapshots.ec2_describe_snapshots_by_volume_id(volume_id).each { |e| 
          if @latest[e.volume_id].nil? or e.date > @latest[e.volume_id].date
            @latest[e.volume_id] = e 
          end
        }
        @latest[volume_id]
      end
    
      def delete_snapshots
        each { |snap| 
          if allow_delete?(snap)
            puts "ec2-delete-snapshot #{snap.id}"
            if DEBUG
              puts '(disabled)'
            else
              %x[ec2-delete-snapshot #{snap.id}] 
            end
          else
            puts "Not deleting #{snap}"
          end
        }
      end
     
      def allow_delete?(snap)
        @opts[:delete_all] or (snap.completed? and !is_current_snapshot?(snap))
      end
      
      def is_current_snapshot?(snap)
        (snap == current_snapshot(snap.volume_id))
      end

      # make the system call and return a new object
      #
      def self.ec2_describe_snapshots(opts = '')
        new( %x[ec2-describe-snapshots #{opts}] )
      end

      def self.ec2_describe_snapshots_by_volume_id(volume_id)
        ec2_describe_snapshots("--filter volume-id=#{volume_id}")
      end
      
      # DOES delete the CURRENT snapshot of SPECIFIED volume
      #
      def self.delete_all_of_volume(volume_id)
        snapshot_rows = %x[ec2-describe-snapshots --filter volume-id=#{volume_id}]
        new( snapshot_rows, :delete_all => true ).delete_snapshots
      end
      
      # does delete ALL of the snapshots of ALL volumes EXCEPT the CURRENT snapshot
      #
      def self.delete_all_available
        ec2_describe_snapshots("-o self").delete_snapshots
      end

      # current_snapshot_id used by the EC2 bootstrap to create a new volume from snapshot
      #
      def self.current_snapshot_id(volume_id)
        ec2_describe_snapshots_by_volume_id(volume_id).current_snapshot(volume_id).id
      end
      
    end
  end
  end
end
