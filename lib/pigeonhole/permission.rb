module Pigeonhole
  module Permission
    
    protected
    
    # Load the password from a config file
    #
    def pincode
      File.read(Rails.root.join('config', 'password.txt'))
    end
    
    def perform_login
      Rails.logger.debug "PERMISSION: Logging in now"
      session[:pincode] = pincode
      session[:timestamp] = Time.now
    end
    
    def login_required
      if (logged_in_via_session? || logged_in_via_form?)
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
      Rails.logger.debug "PERMISSION: timestamp is #{session[:timestamp]}, submitted code is #{session[:pincode]}, pincode is #{pincode}"
      reset_session if session[:timestamp] and session[:timestamp] < 1.hour.ago
      session[:pincode] == pincode
    end
    
    def logged_in_via_form?
      Rails.logger.debug "PERMISSION: timestamp is #{session[:timestamp]}, submitted code is #{params[:login]}, pincode is #{pincode}"
      params[:login] == pincode
    end
    
  end
end
