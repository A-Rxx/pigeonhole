module I18n
  
  # Use it for something like <tt>params[:locale] =~ I18n.available_locales_regexp</tt> to check for valid locales.
  #
  def self.available_locales_regexp
    Regexp.new available_locales.map { |locale| locale.to_s }.join('|')
  end
    
end