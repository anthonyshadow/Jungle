class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with username: ENV['ADMIN_USERNAME'].to_s, password: ENV['ADMIN_PASSWORD'].to_s
  def show
    @products_count= Product.count
    @products_sum = Product.sum(:quantity)
    @categories = Category.count
  end
end
