defmodule Pluggy.CartController do
  require IEx

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

  def add_edit(conn, id, params) do
    IO.puts("Adding to cart")

    ## Get cart_id from session ##
    cart_id = conn.private.plug_session["cart"]

    pizza_ingredients = Postgrex.query!(DB, "SELECT containing_ingredients FROM pizzas WHERE id = $1 LIMIT 1", [String.to_integer(id)]).rows
    pizza_ingredients2 = hd(hd(pizza_ingredients))
    add_ingredients = (params["ingredients"] -- pizza_ingredients2)
    remove_ingredients = (pizza_ingredients2 -- params["ingredients"])




    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)
    Postgrex.query!(
      DB,
      "INSERT INTO carts (uuid, pizza_id, add_ingredients, remove_ingredients, gluten, size) VALUES($1, $2,$3, $4, $5, $6)",
      [
        cart_id,
        id,
        add_ingredients,
        remove_ingredients,
        case params["gluten"] do
          "glutenfri" -> true
          _ -> false
        end,
        case params["pizza_size"] do
          "familj" -> false
          _ -> true
        end
      ])

    redirect(conn, "/menu")
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
