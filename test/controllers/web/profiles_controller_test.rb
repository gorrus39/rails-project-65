# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end
    test 'should get show' do
      sign_in @user
      get profile_url
      assert_response :success
    end

    test 'should NOT get show' do
      assert_raises(
        RuntimeError
      ) { get profile_url }
    end
  end
end
