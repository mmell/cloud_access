module CloudAccess
  class ShellArgs < Array
    
    def initialize(*items)
      super(items)
    end
    
    def to_s
      self.join(' ')
    end
    
  end
  
end
