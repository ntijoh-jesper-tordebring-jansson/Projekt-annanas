defmodule Pluggy.CartController do
  alias Pluggy.Cart
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def add(conn, params) do
    IO.puts("Adding to cart")

    ## Get pizza_id from params ##
    pizza_id = params["pizza_id"]

    ## Get cart_id from session cookie ##
    cart_id = conn.private.plug_session["cart"]

    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)
    Postgrex.query!(
      DB,
      "INSERT INTO carts (uuid, pizza_id, add_ingredients, remove_ingredients, gluten, size) VALUES($1, $2,$3, $4, $5, $6)",
      [
        cart_id,
        pizza_id,
        "",
        "",
        false,
        true
      ])

    redirect(conn, "/menu")
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
