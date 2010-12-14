module Formtastic #:nodoc:
  class SemanticFormBuilder < ActionView::Helpers::FormBuilder

    # Adapted from Formtastic::SemanticFormBuilder.input
    #
    def note(options={})
      options[:label] = localized_string(:note, nil, :label) unless options.key?(:label)
      html_class = [ :note, (options[:pointer] ? 'pointer' : nil) ]
      tab_id = (options[:tab] ? "#{options[:tab]}_" : nil)

      wrapper_html = options.delete(:wrapper_html) || {}
      
      wrapper_html[:id]  ||= generate_html_id("#{tab_id}note").gsub(/_input$/, '')
      wrapper_html[:class] = (html_class << wrapper_html[:class]).flatten.compact.join(' ')

      list_item_content = template.content_tag(:label, options[:label]) + template.content_tag(:span, options[:message])
      return template.content_tag(:li, list_item_content, wrapper_html)
    end

  end
end