# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :check_admin

      private

      def check_admin
        raise 'only for admin' unless current_user
        raise 'only for admin' unless current_user.admin?
      end
    end
  end
end
