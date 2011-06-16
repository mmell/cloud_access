require 'cloud_access/dynamic_attributes.rb'
require 'cloud_access/as/base.rb'
require 'cloud_access/as/create.rb'
require 'cloud_access/as/delete.rb'
require 'cloud_access/as/describe.rb'
require 'csv'

module CloudAccess
  module As

    GeneralOptionFields = [
      :aws_credential_file, 
      :ec2_cert_file_path, 
      :connection_timeout, 
      :delimiter, 
      :headers,
      :access_key_id, 
      :ec2_private_key_file_path, 
      :region, 
      :secret_key, 
      :show_empty_fields,
      :show_request,
      :show_table, 
      :show_long, 
      :show_xml, 
      :quiet,
      :url

    ]

    def As.parse_csv(csv)
      CSV.parse(csv).map { |row| 
        row.map { |item| 
          if item == '(nil)'
            nil 
          elsif item == 'true'
            true
          elsif item == 'false' # not sure this ever appears in an As response
            false
          elsif item.index(',')
            item.split(',')
          else
            item
          end
        }
      }
    end
    
  end
=begin
root$ as-cmd
Command Name                                Description                                            
------------                                -----------                                            
as-create-auto-scaling-group                Create a new auto scaling group                        
as-create-launch-config                     Create a new launch config                             
as-create-or-update-trigger                 Creates a new trigger or updates an existing trigger.  

as-delete-auto-scaling-group                Delete the specified auto scaling group                
as-delete-launch-config                     Delete the specified launch configuration              
as-delete-policy                            Delete the specified policy                            
as-delete-scheduled-action                  Delete the specified scheduled action                  
as-delete-trigger                           Delete a  trigger.                                     

as-describe-adjustment-types                Describes all policy adjustment types.                 
as-describe-auto-scaling-groups             Describes the specified auto scaling group(s)          
as-describe-auto-scaling-instances          Describes the specified auto scaling instance(s)       
as-describe-launch-configs                  Describe the specified launch configurations           
as-describe-metric-collection-types         Describes all metric colle... metric granularity types.
as-describe-policies                        Describes the specified policy/policies                
as-describe-process-types                   Describes all scaling process types.                   
as-describe-scaling-activities              Describe a set of activiti...ties belonging to a group.
as-describe-scheduled-actions               Describes the specified scheduled action(s)            
as-describe-triggers                        Describes a trigger including its internal state.      

as-disable-metrics-collection               Disable collection of AutoScaling group metrics        
as-enable-metrics-collection                Enable collection of AutoScaling group metrics         
as-execute-policy                           Executes the specified policy                          

as-put-scaling-policy                       Creates or updates a scaling policy                    
as-put-scheduled-update-group-action        Creates or updates a scheduled update group action     
as-resume-processes                         Resumes all suspended scal... given auto scaling group.

as-set-desired-capacity                     Set the desired capacity of the auto scaling group     
as-set-instance-health                      Set the health of the instance                         
as-suspend-processes                        Suspends all scaling proce... given auto scaling group.
as-terminate-instance-in-auto-scaling-group Terminate a given instance.                            
as-update-auto-scaling-group                Update specified auto scaling group                    
help                                        
version                                     Prints the version of the CLI tool and the API.        

    For help on a specific command, type '<commandname> --help'
=end

end
