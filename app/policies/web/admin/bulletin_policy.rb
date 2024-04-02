# frozen_string_literal: true

module Web
  module Admin
    class BulletinPolicy < ApplicationPolicy
      def archive?
        may_archive = record.may_archive? # aasm позволяет
        return true if user.admin? && may_archive
        return true if record.user != user # объявление созданное этим юзером

        false
      end
    end
  end
end
