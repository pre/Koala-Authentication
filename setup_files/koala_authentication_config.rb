module KoalaAuthenticationConfig

  # Current project's client name.
  # N.B. This must match the according name from the server.
  CLIENT_NAME = "unset"
  
  # Private key is not known by the authentication clients.
  CLIENT_CONFIGURATION = true

  # URL to the authentication server (do not include trailing slash)
  SERVER_URL = "http://localhost:3000"
  
  # URL to the authentication server's logout url
  SERVER_LOGOUT_URL = SERVER_URL + "/sessions/logout"
  
  # If CLIENT_CONFIGURATION == true, then you don't need the private key.
  SERVER_PRIVATE_KEY_FILE = File.join("#{RAILS_ROOT}", "/config", 'private_server_key.pem')
  SERVER_PUBLIC_KEY_FILE  = File.join("#{RAILS_ROOT}", "/config", 'public_server_key.pem')

end
