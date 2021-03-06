class OrdersController <ApplicationController

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @user = current_user
  end

  def create
    order = current_user.orders.create(order_params)
    cart.items.each do |item, quantity|
      if cart.find_coupon(item) != nil
        order.update(coupon_id: cart.find_coupon(item).id)
      end
    end
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:notice] = "You order was created"
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip, :coupon_id)
  end
end
