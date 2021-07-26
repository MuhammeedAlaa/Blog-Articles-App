class ListCategoriesTest < ActionDispatch::IntegrationTest
    def setup
        @category = Category.create(name: "programming")
        @category2 = Category.create(name: "Books")
    end
    test "should get the categories list" do
        get categories_path
        assert_template "categories/index"
        assert_select "a[href=?]", category_path(@category.id), text: @category.name
        assert_select "a[href=?]", category_path(@category2.id), text: @category2.name
    end

end
