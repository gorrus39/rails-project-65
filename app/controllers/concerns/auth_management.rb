# frozen_string_literal: true

module AuthManagement
  extend ActiveSupport::Concern
  included do
    helper_method :current_user

    def current_user
      User.find_by(id: session['user_id']) if session['user_id'].present?
    end

    def check_admin
      return if current_user&.admin?

      redirect_to root_path, notice: t('.notice')
    end

    def check_current_user
      return if current_user

      redirect_to root_path, notice: t('.notice')
    end
  end
end
