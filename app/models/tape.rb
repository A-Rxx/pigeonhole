class Tape < Package
  
  validates :body, :presence => true
  
  def load
   super
   begin
     File.delete(path)
     exists? ? nil : self
   rescue Errno::ENOENT => e
     nil
   end
  end

end