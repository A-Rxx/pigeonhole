module ObjectExtensions
  
  def not_nil?
    !nil?
  end
  
  def not_blank?
    !blank?
  end
  
  def not_empty?
    !empty?
  end

end

class Object #:nodoc:
  include ObjectExtensions
end