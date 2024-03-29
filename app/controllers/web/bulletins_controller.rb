# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @bulletins = Bulletin.order(created_at: :desc)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end
  end
end
