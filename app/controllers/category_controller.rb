class CategoryController < ApplicationController
  before_action { |c| c.available_to "logged_in" }
  def show
    @category = Category.find(params[:id])
  end
end