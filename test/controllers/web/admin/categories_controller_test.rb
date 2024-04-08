# frozen_string_literal: true

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:admin)
        @category = categories(:one)
        @category_without_bulletins = categories(:without_bulletins)
      end

      test 'should get index' do
        sign_in @admin
        get admin_categories_url
        assert_response :success
      end

      test 'should NOT get index' do
        sign_in @user
        get admin_categories_url

        assert_redirected_to root_path
      end
      test 'should get new' do
        sign_in @admin
        get new_admin_category_url
        assert_response :success
      end

      test 'should create category' do
        sign_in @admin

        name = Faker::Lorem.sentence(word_count: 2)
        post admin_categories_url,
             params: { category: {
               name:
             } }

        assert Category.find_by(name:)
      end

      test 'should get edit' do
        sign_in @admin
        get edit_admin_category_url(@category)
        assert_response :success
      end

      test 'should update category' do
        sign_in @admin

        name = Faker::Lorem.sentence(word_count: 2)
        patch admin_category_url(@category),
              params: { category: { name: } }
        assert Category.find_by(name:)
      end

      test 'should destroy category without bulletins' do
        sign_in @admin
        id = @category_without_bulletins.id
        delete admin_category_url(@category_without_bulletins)

        assert_nil Category.find_by(id:)
      end

      test 'should NOT destroy category with bulletins' do
        sign_in @admin
        id = @category.id
        delete admin_category_url(@category)

        assert Category.find_by(id:)
      end
    end
  end
end
