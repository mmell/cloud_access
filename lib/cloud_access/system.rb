module CloudAccess
  class System
    
    def is_ubuntu?
      @is_ubuntu ||= !(%x[uname -v] =~ /Ubuntu/).nil?
    end
    
    def is_natty? # ubuntu >= 11.04
      return false unless is_ubuntu?
      @uname_v ||= %x[uname -r].match(/(\d+)\.(\d+)\.(\d+).*/) # e.g. 2.6.38-8-virtual
      (@uname_v[1].to_i >= 2 and @uname_v[2].to_i >= 6 and @uname_v[3].to_i >= 38)
    end
  
  end
  
end
