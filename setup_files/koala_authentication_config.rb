module KoalaAuthenticationConfig

  # Current project's client name delivered in the LoginXml
  CLIENT_NAME = Lintuvaara::ApiConfig::SERVER_ACCOUNT
  
  # Private key is not known for authentication clients.
  CLIENT_CONFIGURATION = true

  SERVER_HOST = Lintuvaara::ApiConfig::SERVER_HOST
  SERVER_PROTOCOL = Lintuvaara::ApiConfig::SERVER_PROTOCOL
  
  # URL to the authentication server (do not include trailing slash)
  SERVER_URL = "#{SERVER_PROTOCOL}#{SERVER_HOST}"
  
  # URL to the authentication server's logout url
  SERVER_LOGOUT_URL = SERVER_URL + "/sessions/logout"
  
  # URL to user preferences
  SERVER_USER_PREFERENCES_URL = SERVER_URL + "/user_preferences"
  
  # If CLIENT_CONFIGURATION then you don't need the private key.
  SERVER_PRIVATE_KEY_FILE = ""
  SERVER_PUBLIC_KEY_FILE  = File.join("#{RAILS_ROOT}", "/config", 'lintuvaara_public_key.pem')
  
end
