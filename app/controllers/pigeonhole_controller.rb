class PigeonholeController < ApplicationController
  
  before_filter :login_required, :lock_open_messages
  
  def index
  end
  
  def logout
    reset_session
    redirect_to root_url, :notice => 'You are logged out now. Thank you.'
  end
  
end
