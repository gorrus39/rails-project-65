# frozen_string_literal: true

Sentry.init do |config|
  config.enabled_environments = %w[production]

  config.dsn = 'https://a59f72a882353c3f127daaa29fa2bbfa@o4506834751651840.ingest.us.sentry.io/4506949814190080'
  #   config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  #   config.traces_sampler = lambda do |context|
  #     true
  #   end
end

# example for testing errors.
Sentry.capture_message('test message')
