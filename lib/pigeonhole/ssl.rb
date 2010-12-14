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
      render :text => 'This is no secure SSL/TLS connection.', :status => 408 and return unless (request.ssl? or Rails.env.development?)
    end
    
  end
end