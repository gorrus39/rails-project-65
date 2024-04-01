# frozen_string_literal: true

module Web
  module Profile
    class BulletinsController < Web::Profile::ApplicationController
      def index
        @q = current_user.bulletins.ransack(params[:q])
        @bulletins = @q
                     .result
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(12)
      end
    end
  end
end
