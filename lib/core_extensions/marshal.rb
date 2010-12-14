#require 'digest/sha2'
#require 'openssl'
#
#module MarshalExtensions
#
#  def encrypted(key)
#    StringExtensions.aes(:encrypt, key, self)
#  end
#
#  def decrypted(key)
#    StringExtensions.aes(:decrypt, key, self)
#  end
#  
#  private
#  
#  def self.aes(m, k, t)
#    (aes = OpenSSL::Cipher::Cipher.new('aes-512-cbc').send(m)).key = Digest::SHA512.digest(k)
#    aes.update(t) << aes.final
#    rescue
#    return false
#  end
#  
#end
#
#module Marshal #:nodoc:
#  include MarshalExtensions
#end
