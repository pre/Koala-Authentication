module KoalaAuthenticationConfig

  # Private key is not known for authentication clients.
  CLIENT_CONFIGURATION = true

  # If CLIENT_CONFIGURATION == true, then you don't need the private key.
  SERVER_PRIVATE_KEY_FILE = File.join("#{RAILS_ROOT}", "/config", 'private_server_key.pem')
  SERVER_PUBLIC_KEY_FILE  = File.join("#{RAILS_ROOT}", "/config", 'public_server_key.pem')

  
end