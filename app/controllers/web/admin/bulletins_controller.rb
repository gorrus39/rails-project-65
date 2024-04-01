# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def under_moderation
        @bulletins = Bulletin
                     .under_moderation
                     .page(params[:page])
      end

      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q
                     .result
                     .page(params[:page])
      end
    end
  end
end
