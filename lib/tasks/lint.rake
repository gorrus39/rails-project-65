# frozen_string_literal: true

namespace :lint do
  desc 'rubocop-lint'.yellow
  task rubocop: :environment do
    system('rubocop')
  end
  desc 'slim-lint'.yellow
  task slim: :environment do
    system('slim-lint app/**/*.slim')
  end
end
