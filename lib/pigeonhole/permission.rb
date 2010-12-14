module Pigeonhole
  module Permission
    
    protected
    
    # Load the password from a config file
    #
    def pincode
      begin
        File.read(Rails.root.join('config', 'password.txt'))
      rescue Errno::ENOENT => e
        'hilarious'
      end
    end
    
    def perform_login
      session[:pincode] = pincode
      session[:timestamp] = Time.now
    end
    
    def login_required
      if logged_in_via_session? or logged_in_via_form?
        perform_login
        return true
      else
        redirect_to root_url and return if action_name == 'logout'
        # If somebody deletes the cookie manually, reset_session freaks out. That's why we check if it's empty.
        reset_session unless session.empty?
        @permission_denied = true
        render :template => 'application/login' and return
      end
    end
    
    # Checks whether there has been a successful login before via the session
    #
    def logged_in_via_session?
      reset_session if session[:timestamp] and session[:timestamp] < 1.hour.ago
      session[:pincode] == pincode
    end
    
    def logged_in_via_form?
      params[:login] == pincode
    end
    
  end
end
