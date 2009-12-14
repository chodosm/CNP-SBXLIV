# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pdt_session',
  :secret      => 'ccbd839f12b751c745a9d70607cb2ea902adf05b761572bab8aa80c5265d0151e1a0076619d0765c47d510faa4999d8f287b03784b3e2f82d10ffd68adf2cc8e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
