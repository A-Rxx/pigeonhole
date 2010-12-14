class BinariesController < ApplicationController
  
  before_filter :login_required, :except => [ :show ]
  before_filter :lock_open_messages
  
  def show
    @binary = Binary.find(:id => params[:id], :key => params[:key])
    render :template => 'binaries/tampered' and return unless @binary
    send_data @binary.body, :filename => @binary.name, :type => @binary.mime and return
  end
  
  def new
    @binary = Binary.new
  end
  
  def create
    @binary = if params[:upload].present?
      Binary.new :body => params[:upload].read, :name => params[:upload].original_filename, :mime => params[:upload].content_type
    else
      Binary.new
    end
    if @binary.save
      @pickup_url = show_binary_url(@binary.id, @binary.key, :locale => nil)
      # Prevent double sending the form
      session[:_csrf_token] = ActiveSupport::SecureRandom.base64(32)
    else
      render :template => 'binaries/new' and return
    end
  end
  
end