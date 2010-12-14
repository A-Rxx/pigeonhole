class MessagesController < ApplicationController
  
  before_filter :login_required, :except => [ :show ]
  after_filter :lock_open_messages, :except => [ :show, :download, :attachment ]
  
  # GET/POST
  def show
    # The show method reacts only to GET requests by convention
    # We want it to accept a password via POST, store the password in the session and then redirect it to the GET request
    redirect_to show_message_url, :flash => { :password => params[:password] } and return if request.post?
    # There is a little work-around here, because we cannot save anything in the session here except via the flash
    session[:password] = flash[:password] if flash[:password].present?
    @message = Message.find(:id => params[:id], :key => session[:password])
    render :template => 'messages/password' and return unless @message
    perform_login # On successful read, log in the user
  end
  
  # POST
  def download
    @message = Message.find(:id => params[:id], :key => session[:password])
    send_data @message.to_download, :filename => @message.filename, :type => 'text/plain' and return
  end
  
  # POST
  def attachment
    @message = Message.find(:id => params[:id], :key => session[:password])
    send_data @message.attachment, :filename => @message.name, :type => @message.mime and return
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(:body => params[:body], :key => params[:password])
    @message.errors.add(:key, t('errors.messages.confirmation')) if params[:password] != params[:password_confirmation]
    if params[:upload].present?
      @message.name       = params[:upload].original_filename
      @message.mime       = params[:upload].content_type
      @message.attachment = params[:upload].read
    end
    if @message.save
      @pickup_url = show_message_url(@message.id, :locale => nil)
      # Prevent double sending the form
      session[:_csrf_token] = ActiveSupport::SecureRandom.base64(32)
    else
      render :template => 'messages/new' and return
    end
  end
  
  def destroy
    @message = Message.find(:id => params[:id], :key => session[:password])
    @message.try(:destroy)
    redirect_to root_url and return
  end
  
end