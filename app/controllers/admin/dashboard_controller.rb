class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  
  def show
  end

  def total_products
    Product.count
  end
  helper_method :total_products

  def total_categories
    Category.count
  end
  helper_method :total_categories

end
