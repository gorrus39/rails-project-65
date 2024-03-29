# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def under_moderation
        @bulletins = Bulletin.under_moderation
      end
    end
  end
end
