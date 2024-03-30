# frozen_string_literal: true

module Web
  module Profile
    class BulletinsController < Web::Profile::ApplicationController
      def index
        @bulletins = current_user&.bulletins
      end

      def under_moderation
        @bulletins = Bulletin.under_moderation
      end
    end
  end
end
