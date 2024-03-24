# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def request
      puts request.inspect
      puts params.inspect
      puts 'here'
    end

    def callback
    end
  end
end
