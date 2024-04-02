# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    protected

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end
  end
end
