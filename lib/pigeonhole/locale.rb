module Pigeonhole
  module Locale
    
    # –––––––––––
    # Constructor
    # –––––––––––
    
    # This module will be included by the ApplicationController.
    # We would like to have the ApplicationController to run a before_filter to check for the locale
    #
    def self.included(base)
      base.before_filter :set_locale, :force_locale_on_root_path
    end
    
    # ––––––––––––––––
    # Instance Methods
    # ––––––––––––––––
    
    protected
    
    def default_url_options(options={})
      { :locale => I18n.locale }.update(options)
    end
    
    # Choose the language for the current user
    #
    def set_locale
      # Either through a param, that has highest priority
      locale = if params[:locale]
        params[:locale].to_s
      # Then let's check the browser if there was no param
      elsif accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
        # TODO: Facebook would like to have the country when using authentication there. We should save the browser country somewhere.
        accept_language.scan(/^[a-z]{2}/).first.to_s
      end
      I18n.locale = locale if locale.present? and I18n.available_locales.include?(locale.to_sym)
    end
    
    # When no locale was chosen and somebody comes to the website for the first time,
    # make sure to choose a language first. Because we want the URL to be http://index/en and not http://index
    #
    def force_locale_on_root_path
      # Do *not* force the locale to be shown in the URL (via redirect) if
      # * A user wants to switch his language (param)
      # * This is not the root path
      # * This is an API or JavaScript call (i.e. no :html)
      if params[:locale].blank? and request and request.url == root_url(:locale => nil) and request.get? and request.format.symbol == :html
        respond_to do |format|
          format.html { redirect_to root_path(:locale => I18n.locale) and return }
        end
      end
    end
    
  end
end