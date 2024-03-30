# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def to_moderate?
    return false unless record.may_to_moderate? # aasm не позволяет
    return false unless user # не залогинненый юзер
    return false if user.admin? # админу нельзя отправлять на модерацию
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
    return true if my_bulletin && may_publish

    false
  end

  def reject?
    may_reject = record.may_reject? # aasm позволяет
    return true if my_bulletin && may_reject

    false
  end

  def archive?
    may_archive = record.may_archive? # aasm позволяет
    return true if my_bulletin && may_archive

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
    return true if user && !user.admin?

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
