class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_username"], password: ENV["ADMIN_password"]

  def show
    @categories = Category.all
    @products = Product.all
    @categories_count = Category.count
    @product_count = Product.count
  end

end
