defmodule Pluggy.OrderController do
  alias Pluggy.Order
  alias Pluggy.Pizza
  alias Pluggy.Cart

  import Pluggy.Template, only: [render: 3, render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def remove(conn, params) do
    id_str = params["id"]
    IO.inspect(params)
    id = String.to_integer(id_str)
    IO.puts("Removing from cart")
    Postgrex.query!(DB, "DELETE FROM carts WHERE id = $1", [id])
    redirect(conn, "/menu")
  end

  def submit_order(conn, params) do
    {{_year, _month, _day}, {hour, _minute, _second}} = :calendar.local_time()

    if hour >= 8 and hour < 20 do
      IO.puts("Ordern går igenom eftersom tiden är mellan 08 och 20.")

      # Collect data from users cart
      cart = Cart.all(conn)
      # get customer name
      customer = params["checkout_name"]
      # save users uuuid so we can delete cart data afterwards
      user_uuid = conn.private.plug_session["cart"]
      IO.puts("Submitting order")
      # add one pizza each time the funktion run
      for pizza <- cart do
        Postgrex.query!(
          DB,
          "INSERT INTO orders(pizza_name, added_ingredients, removed_ingredients, customer, is_done, size, gluten) VALUES($1, $2, $3, $4, $5, $6, $7)",
          [
            pizza.pizza_name,
            pizza.add_ingredients,
            pizza.remove_ingredients,
            customer,
            false,
            pizza.size,
            pizza.gluten
          ]
        )
      end

      Postgrex.query!(DB, "DELETE FROM carts WHERE uuid = $1", [user_uuid])

      send_resp(
        conn,
        200,
        render(conn, "pizzas/order_confirmation",
          pizzas: Pizza.all(),
          orders: Order.all(),
          customer: customer
        )
      )
    else
      IO.puts("beställningar kan endast läggas mellan 08 och 20.")
      redirect(conn, "/closed")
    end
  end

  def closed(conn) do
    {{_year, _month, _day}, {hour, _minute, _second}} = :calendar.local_time()

    if hour >= 8 and hour < 20 do
      redirect(conn, "/")
    else
      send_resp(conn, 200, render(conn, "pizzas/closed"))
    end
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
