class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to admin_products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_products_path
    flash[:notice] = "Update Success"
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:alert] = "Product deleted"
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end
