# frozen_string_literal: true

module Web
  module Admin
    module NavHelper
      def active_admin_link?(link_type)
        # ['admin'] | ['admin', 'bulletins'] | ['admin', 'categories']
        paths = request.path.split('/').slice(1..)

        if admin_root_path?(paths, link_type) ||
           admin_bulletins_path?(paths, link_type) ||
           admin_categories_path?(paths, link_type)
          'active'
        else
          ''
        end
      end

      private

      def admin_root_path?(paths, link_type)
        (link_type == :root) && paths.count == 1
      end

      def admin_bulletins_path?(paths, link_type)
        (link_type == :bulletins) && paths.last == 'bulletins'
      end

      def admin_categories_path?(paths, link_type)
        # дополнительная проверка на экшн делаем, так как
        # не понятно по каким причинам, когда отправляем пустое поле в :name (форма category)
        # контроллер делает render :new, но почему - то сдесть в request нету 'new' пути...
        (link_type == :categories) && paths.last == 'categories' && action_index?
      end

      def action_index?
        request.filtered_parameters[:action] == 'index'
      end
    end
  end
end
