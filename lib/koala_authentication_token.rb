require 'openssl'  
require 'base64'

class KoalaAuthenticationToken

  attr_accessor :base64_data, :base64_key, :base64_iv, :plain_data

  @@private_key = OpenSSL::PKey::RSA.new(File.read(SERVER_PRIVATE_KEY_FILE)) unless KoalaAuthenticationConfig::CLIENT_CONFIGURATION
  @@public_key = OpenSSL::PKey::RSA.new(File.read(SERVER_PUBLIC_KEY_FILE))  
    
  def initialize(data, format)
    case format when :plain
      self.encrypt_sensitive(plain_data)
    when :encrypted
      self.decrypt_sensitive(data)
    else
      raise ArgumentError.new("Incorrect format parameter '#{format}', only :plain and :encrypted allowed.")
    end
  end
  
  def decrypt_sensitive(data = {})  
    raise "data: #{data.inspect}"
    cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')  
    cipher.decrypt  
    cipher.key = @@private_key.private_decrypt(self.encrypted_key)  
    cipher.iv = @@private_key.private_decrypt(self.encrypted_iv)  

    decrypted_data = cipher.update(self.encrypted_data)  
    decrypted_data << cipher.final  
  end  
  # 
  #def clear_sensitive  
  #  self.encrypted_data = self.encrypted_key = self.encrypted_iv = nil  
  #end  
  
  protected
  
  def encrypt_sensitive(plain_data)
    cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')  
    cipher.encrypt  
    cipher.key = random_key = cipher.random_key  
    cipher.iv = random_iv = cipher.random_iv  

    encrypted_data = cipher.update(plain_data)  
    encrypted_data << cipher.final 
    self.base64_data = Base64.encode64(encrypted_data) 

    self.base64_key = Base64.encode64(@@private_key.private_encrypt(random_key))
    self.base64_iv = Base64.encode64(@@private_key.private_encrypt(random_iv))
  end
end
