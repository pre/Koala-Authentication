require 'openssl'  
require 'base64'

class KoalaAuthenticationToken

  # TODO: Tarvitsisiko näiden olla ennemmin jossain konffattavassa tiedostossa?
  #       Olivat initializerina ennen kuin tein tästä pluginin.
  SERVER_PRIVATE_KEY_FILE = File.join("#{RAILS_ROOT}", "/config", 'private_server_key.pem')
  SERVER_PUBLIC_KEY_FILE  = File.join("#{RAILS_ROOT}", "/config", 'public_server_key.pem')
  
  attr_accessor :base64_data, :base64_key, :base64_iv

  @@private_key = OpenSSL::PKey::RSA.new(File.read(SERVER_PRIVATE_KEY_FILE))
  @@public_key = OpenSSL::PKey::RSA.new(File.read(SERVER_PUBLIC_KEY_FILE))  
    
  def initialize(plain_data)  
    self.encrypt_sensitive(plain_data)
  end
  
  # def decrypt_sensitive(password)  
  #   if self.encrypted_data  
  #     private_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['private_key']),password)  
  #     cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')  
  #     cipher.decrypt  
  #     cipher.key = private_key.private_decrypt(self.encrypted_key)  
  #     cipher.iv = private_key.private_decrypt(self.encrypted_iv)  
  # 
  #     decrypted_data = cipher.update(self.encrypted_data)  
  #     decrypted_data << cipher.final  
  #   else  
  #     ''  
  #   end  
  # end  
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
