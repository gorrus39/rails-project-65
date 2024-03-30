require 'test_helper'

class BulletinePolicyTest < ActionDispatch::IntegrationTest
  include Pundit::Authorization

  setup do
    @admin = users(:admin)
    @bulletin = bulletins(:one)
  end

  test 'bulletin actions for an administrator' do
    sign_in @admin

    assert policy(@bulletin).show?
    assert_not policy(@bulletin).edit?
  end
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
