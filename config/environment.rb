# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  port:           '25', # or 2525
  address:        ENV['POSTMARK_SMTP_SERVER'],
  user_name:      ENV['POSTMARK_API_KEY'],
  password:       ENV['POSTMARK_API_KEY'],
  domain:         'kerstman.heroku.com',
  authentication: :cram_md5, # or :plain for plain-text authentication
  enable_starttls_auto: true, # or false for unencrypted connection
}
ActionMailer::Base.delivery_method = :smtp
