# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy to_moderate publish reject archive]
    after_action :verify_authorized, only: %i[show new create edit update to_moderate publish reject archive]

    def to_moderate
      authorize @bulletin
      @bulletin.to_moderate
      @bulletin.save
      flash[:notice] = t('.notice')

      redirect_to profile_path
    end

    def publish
      authorize @bulletin
      @bulletin.publish
      @bulletin.save
      flash[:notice] = t('.notice')

      redirect_to profile_path
    end

    def reject
      authorize @bulletin
      @bulletin.reject
      @bulletin.save
      flash[:notice] = t('.notice')

      redirect_to profile_path
    end

    def archive
      authorize @bulletin
      @bulletin.archive
      @bulletin.save
      flash[:notice] = t('.notice')

      redirect_to profile_path
    end

    def index
      @bulletins = Bulletin.published.order(created_at: :desc)
    end

    def show
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def edit
      authorize @bulletin
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      authorize @bulletin

      @bulletin.user = current_user

      if @bulletin.save
        path = request.referer || root_path
        redirect_to path, notice: t('.notice')
      else
        flash[:alert] = t('.alert')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: t('.notice')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @bulletin.destroy!
      redirect_to bulletins_url, notice: t('.notice')
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
