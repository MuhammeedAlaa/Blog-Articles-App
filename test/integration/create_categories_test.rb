class CreateCategoriesTest < ActionDispatch::IntegrationTest
    def setup
     @user = User.create(username: "MuhammadAlaa9", email: "mado@gmail.com", password: "test123", admin: true)
    end
    test "get new category form and create category" do
        sign_in_as(@user, "test123")
        get new_category_path
        assert_template 'categories/new'
        assert_difference 'Category.count', 1 do
            post categories_path, params: {category: {name: "Sports"}}
            follow_redirect!
        end
        assert_template 'categories/index'
        assert_match 'sports', response.body
    end
    test "invalid category submission" do
        sign_in_as(@user, "test123")
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count' do
            post categories_path, params: {category: {name: " "}}
        end
        assert_template 'categories/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end
