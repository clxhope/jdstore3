class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart #确保是当前购物车
    @cart_item = @cart.cart_items.find_by(product_id: params[:id]) #找到要删除的item的id，这个有两个条件，就是要先找商品id，再找item的id，所以用了find_by
    @product = @cart_item.product #确保下面的title是item商品里的title，确保唯一性
    @cart_item.destroy

    flash[:warning] = "成功将 #{@product.title} 从购物车删除"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])

    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = "成功变更数量"
    else
      flash[:warning] = "数量不足以加入购物车"
    end

    redirect_to carts_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
