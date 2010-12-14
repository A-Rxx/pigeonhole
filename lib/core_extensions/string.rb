require 'digest/sha2'
require 'openssl'

module StringClassMethods
  
  def random(length=20)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    result = ''
    length.times { |i| result << chars[rand(chars.size-1)] }
    result
  end
  
  def aes(m, k, t)
    (aes = OpenSSL::Cipher::Cipher.new('aes-256-cbc').send(m)).key = Digest::SHA256.digest(k)
    aes.update(t) << aes.final
    rescue
    return false
  end
  
end

module StringExtensions
  
  def hashed
    Digest::SHA2.hexdigest self
  end

  def encrypted(key)
    self.class.aes(:encrypt, key, self)
  end

  def decrypted(key)
    self.class.aes(:decrypt, key, self)
  end
  
  def with_line_breaks
    gsub("\n", '<br/>')
  end

end

class String #:nodoc:
  include StringExtensions
  extend StringClassMethods
end
