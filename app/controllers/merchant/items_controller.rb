class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.where("id = #{current_user.merchant.id}").first
  end

  def update
    @item = Item.find(params[:id])
    @item.switch_active_status
    switch_active_with_flash(@item)
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:notice] = "#{item.name} has been deleted"
    redirect_to "/merchant/items"
  end

  def switch_active_with_flash(item)
    if item.active?
      flash[:success] = "#{item.name} is activated"
    else
      flash[:success] = "#{item.name} is deactivated"
    end
    redirect_to '/merchant/items'
  end

end
