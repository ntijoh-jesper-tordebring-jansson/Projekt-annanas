defmodule Pluggy.PizzaController do
  # require IEx

  alias Pluggy.Pizza
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  # Send back index page when requested
  def index(conn) do
    if conn.cookies["cart"] == nil do
      Map.put(conn.cookies, "cart", UUID.uuid4)
    end
    send_resp(conn, 200, render("pizzas/index", data: []))
  end

  def checkout(conn) do
    send_resp(conn, 200, render("pizzas/checkout", Cart.all(conn.cookies["cart"])))
  end

  # Send back menu page when requested with data (all pizzas)
  def menu(conn) do
    send_resp(conn, 200, render("pizzas/menu", pizzas: Pizza.all()))
  end

  def edit(conn, id) do
    send_resp(conn, 200, render("pizzas/edit", pizza: Pizza.get(id), ingredients: Pizza.ingredients))
  end

  # defp redirect(conn, url) do
  #   Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  # end
end
