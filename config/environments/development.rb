# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

WEB_URL    = 'http://sbxliv.clickandpark.com'
EVENTS_URL = 'http://www.clickandpark.com/apps/events'

SBXLII_EVENT_ID = 2101
NFLOL_EVENT_ID  = 2091
NFLOL_SB_EVENT_ID = 2091
NFLOL_PB_EVENT_ID = 2081
PWEEK_EVENT_ID  = 2051
NFLXP_EVENT_ID  = 1
PEPSI_EVENT_ID  = 1

