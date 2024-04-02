# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]
      after_action :verify_authorized, only: %i[publish reject archive]

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

      def publish
        authorize @bulletin
        @bulletin.publish
        @bulletin.save
        flash[:notice] = t('.notice')

        redirect_to request.referer
      end

      def reject
        authorize @bulletin
        @bulletin.reject
        @bulletin.save
        flash[:notice] = t('.notice')

        redirect_to request.referer
      end

      def archive
        authorize @bulletin
        @bulletin.archive
        @bulletin.save
        flash[:notice] = t('.notice')

        redirect_to request.referer
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
