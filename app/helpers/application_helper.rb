# frozen_string_literal: true

module ApplicationHelper
  def admin_page?
    request.path.include?('admin')
  end

  def profile_page?
    request.path.include?('profile')
  end

  def admin_all_bulletins_page?
    request.path.include?('admin/bulletins')
  end
end
