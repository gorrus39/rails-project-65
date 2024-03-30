require 'test_helper'

class BulletinePolicyTest < ActionDispatch::IntegrationTest
  include Pundit::Authorization
  # all_bulletin_actions = %i[show new create edit update to_moderate publish reject archive]
  setup do
    @admin = users(:admin)
    @bulletin_under_moderation = bulletins(:under_moderation)
  end

  test '@admin with @bulletin_under_moderation' do
    sign_in @admin

    # allows
    %i[show? publish? reject? archive?].each do |action|
      assert policy(@bulletin_under_moderation).send(action), "raise with #{action}"
    end

    # disallows
    %i[new? create? edit? update? to_moderate?].each do |action|
      assert_not policy(@bulletin_under_moderation).send(action), "raise with #{action}"
    end
  end
end
