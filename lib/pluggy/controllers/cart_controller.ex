defmodule Pluggy.CartController do
  alias Pluggy.Cart
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def add(conn, params) do
    IO.puts("Adding to cart")

    ## Get pizza_id from params ##
    pizza_id = String.to_integer(params["pizza_id"])

    ## Get cart_id from session cookie ##
    cart_id = conn.cookies["cart"]

    size = true
    gluten = false
    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)

    render(conn, "/menu")
  end
end
