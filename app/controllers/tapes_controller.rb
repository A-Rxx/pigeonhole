class TapesController < ApplicationController
  
  before_filter :login_required, :except => [ :show ]
  before_filter :lock_open_messages
  
  def show
    @tape = Tape.find(:id => params[:id], :key => params[:key])
    render :template => 'tapes/tampered' and return unless @tape
    perform_login # On successful read, log in the user
  end
  
  def download
    content  = ActiveSupport::Base64.decode64(params[:content].to_s)
    filename = params[:filename].to_s
    send_data content, :filename => filename, :type => 'text/plain' and return
  end
  
  def new
    @tape = Tape.new
  end
  
  def create
    @tape = Tape.new(:body => params[:tape][:body])
    if @tape.save
      @pickup_url = show_tape_url(@tape.id, @tape.key, :locale => nil)
      # Prevent double sending the form
      session[:_csrf_token] = ActiveSupport::SecureRandom.base64(32)
    else
      render :template => 'tapes/new' and return
    end
  end
  
end
