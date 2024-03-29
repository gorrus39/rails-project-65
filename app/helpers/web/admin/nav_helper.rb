# frozen_string_literal: true

module Web
  module Admin
    module NavHelper
      def active_admin_link?(link_type)
        # ['admin'] | ['admin', 'bulletins'] | ['admin', 'categories']
        paths = request.path.split('/').slice(1..)
        is_root = (link_type == :root) && paths.count == 1
        is_bulletins = (link_type == :bulletins) && paths.last == 'bulletins'
        is_categories = (link_type == :categories) && paths.last == 'categories'

        if is_root || is_bulletins || is_categories
          'active'
        else
          ''
        end
      end
    end
  end
end
