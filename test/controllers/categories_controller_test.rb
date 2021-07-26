require 'test_helper'
class CategoriesControllerTest < ActionDispatch::IntegrationTest
    def setup
     @category = Category.create(name: "Sports")  
     @user = User.create(username: "MuhammadAlaa9", email: "mado@gmail.com", password: "test123", admin: true)
        
    end
    
    test "should get categories index" do
        get categories_path
        assert_response :success
    end
    test "should get new" do
        sign_in_as(@user,"test123")
        get new_category_path
        assert_response :success

    end
 
    test "should get show" do
        get category_path(@category.id)
        assert_response :success
    end
    test "should redirect when not admin" do
        assert_no_difference "Category.count" do
            post categories_path, params: {category: {name: "sports"}}
        end
        assert_redirected_to categories_path
    end
end