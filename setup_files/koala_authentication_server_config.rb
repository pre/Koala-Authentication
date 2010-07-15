module KoalaAuthenticationConfig
  
  # Current project's client name.
  # N.B. This must match the according name from the server.
  CLIENT_NAME = "unset"
  
  # Private key is not known by the authentication clients.
  CLIENT_CONFIGURATION = false

  # URL to the authentication server (do not include trailing slash)
  SERVER_URL = "unset"
    
  # URL to the authentication server's logout url
  SERVER_LOGOUT_URL = SERVER_URL + "/sessions/logout"
  
  # If CLIENT_CONFIGURATION == true, then you don't need the private key.
  SERVER_PRIVATE_KEY_FILE = File.join("#{RAILS_ROOT}", "/config", 'lintuvaara_private_key.pem')
  SERVER_PUBLIC_KEY_FILE  = File.join("#{RAILS_ROOT}", "/config", 'lintuvaara_public_key.pem')

end
