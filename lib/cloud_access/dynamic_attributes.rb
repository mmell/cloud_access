module CloudAccess
  
  # to obtain the magic, extend this in your class and then call
  #  dynamic_attributes *Fields
  # The class must have a hash named @data which will be the source for method response.
  #
  module DynamicAttributes
        
    # create accessors for all of the fields
    # Thanks http://blog.jayfields.com/2008/02/ruby-replace-methodmissing-with-dynamic.html
    #
    def dynamic_attributes(*args)          
      args.each do |attribute|
        next if attribute == :type
        define_method attribute do
          @data[attribute]
        end
      end
    end
    
  end
  
end
