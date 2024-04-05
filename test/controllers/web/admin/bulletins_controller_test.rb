# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @user = users(:one)
        @bulletin = bulletins(:one)
        @bulletin_under_moderation = bulletins(:under_moderation)
      end

      test 'should get index' do
        sign_in @admin
        get admin_root_url
        assert_response :success
      end
      test 'should NOT get index' do
        sign_in @user
        assert_raises(
          Exception
        ) { get admin_root_url }
      end

      test 'shold get under_moderation bulletins' do
        sign_in @admin
        get admin_bulletins_url
        assert_response :success
      end

      test 'should publish bulletin' do
        sign_in @admin
        attach_file_to(@bulletin_under_moderation)
        patch publish_admin_bulletin_url(@bulletin_under_moderation)
        assert { Bulletin.find(@bulletin_under_moderation.id).state == 'published' }
      end

      test 'should NOT publish bulletin' do
        attach_file_to(@bulletin_under_moderation)
        assert_raises(Exception) { patch publish_admin_bulletin_url(@bulletin_under_moderation) }
      end

      test 'should reject bulletin' do
        sign_in @admin
        attach_file_to(@bulletin_under_moderation)
        patch reject_admin_bulletin_url(@bulletin_under_moderation)
        assert { Bulletin.find(@bulletin_under_moderation.id).state == 'rejected' }
      end

      test 'should NOT reject bulletin' do
        attach_file_to(@bulletin_under_moderation)
        assert_raises(Exception) { patch reject_admin_bulletin_url(@bulletin_under_moderation) }
      end

      test 'should archive bulletin' do
        sign_in @admin
        attach_file_to(@bulletin)
        patch archive_admin_bulletin_url(@bulletin)
        assert { Bulletin.find(@bulletin.id).state == 'archived' }
      end

      test 'should NOT archive bulletin' do
        attach_file_to(@bulletin)
        assert_raises(Exception) { patch archive_admin_bulletin_url(@bulletin) }
      end

      def attach_file_to(bulletin)
        bulletin.image.attach(io: Rails.root.join('test/fixtures/files/first.png').open, filename: 'filename.png')
      end
    end
  end
end
