# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
    @admin = users(:admin)
    @category = categories(:one)
    image_path = Rails.root.join('test/fixtures/files/man.jpg')
    @image = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user

    get new_bulletin_url
    assert_response :success
  end

  # test 'should NOT get new' do
  #   get new_bulletin_url
  #   assert_response :unprocessible_entinity
  # end

  test 'should create bulletin' do
    sign_in @user

    new_title = Faker::Lorem.sentence(word_count: 3)
    post bulletins_url,
         params: { bulletin: {
           category_id: @category.id,
           description: Faker::Lorem.paragraph,
           title: new_title,
           image: @image
         } }

    assert Bulletin.find_by(title: new_title)
  end

  test 'should show bulletin' do
    sign_in @admin
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get edit' do
    sign_in @user
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    sign_in @user

    new_title = Faker::Lorem.sentence(word_count: 3)
    patch bulletin_url(@bulletin),
          params: { bulletin: { category_id: @bulletin.category_id,
                                description: @bulletin.description,
                                title: new_title,
                                user_id: @bulletin.user_id,
                                image: @image } }
    assert Bulletin.find_by(title: new_title)
  end

  test 'should destroy bulletin' do
    assert_difference('Bulletin.count', -1) do
      delete bulletin_url(@bulletin)
    end

    assert_redirected_to bulletins_url
  end
end
