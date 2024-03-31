# frozen_string_literal: true

module Web
  module Admin
    module Bulletins
      module SearchFormHelper
        def categories_as_options
          Category.all.map { |category| [category.name, category.id] }
        end
      end
    end
  end
end
