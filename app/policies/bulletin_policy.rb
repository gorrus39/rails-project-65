# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def to_moderate?
    return false unless record.may_to_moderate? # aasm не позволяет
    return false unless user # не залогинненый юзер
    return false if record.user != user # объявление созданное этим юзером

    true
  end

  def show?
    return true if record.published? # опубликованное объявление
    return true if my_bulletin
    return true if user.admin?

    false
  end

  def publish?
    may_publish = record.may_publish? # aasm позволяет
    return true if may_publish && user.admin?

    false
  end

  def reject?
    may_reject = record.may_reject? # aasm позволяет
    return true if user.admin? && may_reject

    false
  end

  def archive?
    may_archive = record.may_archive? # aasm позволяет
    return true if user.admin? && may_archive
    return true if record.user == user # объявление созданное этим юзером

    false
  end

  def edit?
    return true if my_bulletin

    false
  end

  def update?
    edit?
  end

  def new?
    return true if user

    false
  end

  def create?
    new?
  end

  private

  def my_bulletin
    record.user == user # объявление созданное этим юзером
  end
end
# app_1  | Error:
# app_1  | Web::Admin::BulletinsControllerTest#test_should_archive:
# app_1  | Pundit::NotDefinedError: unable to find policy `NilClassPolicy` for `nil`
# app_1  |     app/controllers/web/admin/bulletins_controller.rb:40:in `archive'
# app_1  |
# app_1  | bin/rails test /project/test/controllers/web/admin/bulletins_controller_test.rb:37
# app_1  |
# app_1  | E
# app_1  |
# app_1  | Error:
# app_1  | Web::Admin::BulletinsControllerTest#test_should_reject:
# app_1  | Pundit::NotDefinedError: unable to find policy `NilClassPolicy` for `nil`
# app_1  |     app/controllers/web/admin/bulletins_controller.rb:31:in `reject'
# app_1  |
# app_1  | bin/rails test /project/test/controllers/web/admin/bulletins_controller_test.rb:26
# app_1  |
# app_1  | .E
# app_1  |
# app_1  | Error:
# app_1  | Web::Admin::BulletinsControllerTest#test_should_publish:
# app_1  | Pundit::NotDefinedError: unable to find policy `NilClassPolicy` for `nil`
# app_1  |     app/controllers/web/admin/bulletins_controller.rb:22:in `publish'
# app_1  |
# app_1  | bin/rails test /project/test/controllers/web/admin/bulletins_controller_test.rb:16
