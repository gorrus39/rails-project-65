require 'test_helper'

class BulletinePolicyTest < ActionDispatch::IntegrationTest
  include Pundit::Authorization

  setup do
    # @account = build_stubbed(:account)
    @admin = users(:admin)
    # @employee = build_stubbed(:employee, account: @account)
    # @post = build_stubbed(:post, account: @account)
    @bulletin = bulletins(:one)
  end
  # bulletin_actions = %i[
  #   show
  #   new
  #   create
  #   edit
  #   update
  #   to_moderate
  #   publish
  #   reject
  #   archive
  # ]
  test 'bulletin actions for an administrator' do
    sign_in @admin

    assert policy(@bulletin).show?
    assert_not false
    # assert policy(@bulletin).edit?
  end
end
