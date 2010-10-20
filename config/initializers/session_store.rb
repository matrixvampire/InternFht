# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_InternFht_session',
  :secret      => '7fd2968824dfa7ba4e854425285f5abe2e1e15d6e0ac431f06365d921ae4f0b2fa4335daed47b6504b5014a88c94fc7eb6c69a57d7664c6e5bad4ccbbfb7b178'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
