defmodule Pluggy.CartController do
  alias Pluggy.Cart
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def add(conn, params) do
    IO.puts("Adding to cart")
    size = params["size"]
    ## Get pizza_id from params ##
    pizza_id = String.to_integer(params["pizza_id"])

    ## Get cart_id from params ##
    cart_id = params["cart_id"]

    # ## Get cart from DB ##
    # cart = Cart.get_cart(cart_id)

    # ## Add ingredients to cart ##
    # new_cart = Cart.add_ingredients(cart, pizza_id, add_ingredients)

    # ## Remove ingredients from cart ##
    # new_cart = Cart.remove_ingredients(new_cart, pizza_id, remove_ingredients)

    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)

    render(conn, "/menu")
  end
end
