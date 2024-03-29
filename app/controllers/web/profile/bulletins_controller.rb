# frozen_string_literal: true

module Web
  module Profile
    class BulletinsController < Web::Profile::ApplicationController
      before_action :set_bulletin, only: %i[edit update destroy]

      def index
        @bulletins = current_user&.bulletins
      end

      def under_moderation
        @bulletins = Bulletin.under_moderation
      end

      def new
        @bulletin = Bulletin.new
      end

      def edit; end

      def create
        @bulletin = Bulletin.new(bulletin_params)
        @bulletin.user = current_user

        if @bulletin.save
          redirect_to profile_root_path, notice: t('.notice')
          # redirect_to bulletin_url(@bulletin), notice: t('.notice')
        else
          flash[:alert] = t('.alert')
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /bulletins/1 or /bulletins/1.json
      def update
        respond_to do |format|
          if @bulletin.update(bulletin_params)
            format.html { redirect_to bulletin_url(@bulletin), notice: t('.notice') }
            format.json { render :show, status: :ok, location: @bulletin }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @bulletin.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /bulletins/1 or /bulletins/1.json
      def destroy
        @bulletin.destroy!

        respond_to do |format|
          format.html { redirect_to bulletins_url, notice: t('.notice') }
          format.json { head :no_content }
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end

      def bulletin_params
        params.require(:bulletin).permit(:title, :description, :category_id, :image)
      end
    end
  end
end
