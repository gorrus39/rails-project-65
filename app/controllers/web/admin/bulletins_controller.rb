# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]
      after_action :verify_authorized, only: %i[publish reject archive]

      def index
        @q = Bulletin.send(params[:filter]).ransack(params[:q])
        @bulletins = @q
                     .result
                     .page(params[:page])
      end

      def publish
        authorize @bulletin
        if @bulletin.may_publish?
          @bulletin.publish
          @bulletin.save
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end

      def reject
        authorize @bulletin
        if @bulletin.may_reject?
          @bulletin.reject
          @bulletin.save
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end

      def archive
        authorize @bulletin
        if @bulletin.may_archive?
          @bulletin.archive
          @bulletin.save
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end
    end
  end
end
