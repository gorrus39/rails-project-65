# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  
  helper_method :current_user

  def current_user
    User.find_by(id: session['user_id']) if session['user_id'].present?
  end
end
