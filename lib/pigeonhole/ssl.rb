module Pigeonhole
  module SSL
    
    # –––––––––––
    # Constructor
    # –––––––––––
    
    def self.included(base)
      base.before_filter :assert_ssl
    end
    
    # ––––––––––––––––
    # Instance Methods
    # ––––––––––––––––
    
    protected
    
    def assert_ssl
      return true if (request.ssl? or Rails.env.development?)
      render :text => 'This is no secure SSL/TLS connection.', :status => 408 and return
    end
    
  end
end