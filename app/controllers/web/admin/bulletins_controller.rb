# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def under_moderation
        @bulletins = Bulletin.under_moderation
      end

      def index
        @bulletins = Bulletin.all
      end
    end
  end
end
