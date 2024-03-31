# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user

  def current_user
    User.find_by(id: session['user_id']) if session['user_id'].present?
  end

  def check_admin
    raise 'only for loggined users' unless current_user
    raise 'only for admin' unless current_user.admin?
  end

  def check_current_user
    raise 'only for loggined users' unless current_user
  end
end
