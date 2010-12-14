class ApplicationController < ActionController::Base
  
  include Pigeonhole::Locale
  include Pigeonhole::Permission
  include Pigeonhole::SSL
  
  protect_from_forgery
  
  before_filter :cleanup
  
  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    redirect_to :root
  end
  
  protected
  
  # Delete outdated packages
  #
  def cleanup
    Dir.glob(File.join(PATH_UPLOAD, '*')) do |file|
      File.delete(file) if File.mtime(file) < 14.days.ago
    end
  end
  
  def lock_open_messages
    # In case there was a message read earlier, its password is still in the session. Let's kill it.
    session[:password] = nil
  end
  
end