# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :set_category, only: %i[destroy]

      def index
        @categories = Category.all
      end

      def destroy
        @category.destroy!
        redirect_to admin_categories_url, notice: t('.notice')
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      # def bulletin_params
      #   params.require(:bulletin).permit(:title, :description, :category_id, :image)
      # end
    end
  end
end
