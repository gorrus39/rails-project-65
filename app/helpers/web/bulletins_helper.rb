# frozen_string_literal: true

module Web
  module BulletinsHelper
    def categories_as_options
      Category.all.map { |category| [category.name, category.id] }
    end
  end
end
