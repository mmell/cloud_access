module CloudAccess
  module As
    module Base
    
      def is_valid?
         0 == (@response =~ /^OK/)
      end

    end
  end
end
