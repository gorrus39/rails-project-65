# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :check_current_user

    def show
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q
                   .result
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(12)
    end
  end
end
