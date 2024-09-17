defmodule Pluggy.PizzaController do
  require IEx

  alias Pluggy.Cart
  alias Pluggy.Pizza
  import Pluggy.Template, only: [render: 3, render: 2]
  import Plug.Conn, only: [send_resp: 3]

  # Send back index page when requested
  def index(conn) do
    if conn.private.plug_session["cart"] == nil do
      Plug.Conn.put_session(conn, :cart, UUID.uuid4())
      |> redirect("/")
    end

    send_resp(conn, 200, render(conn, "pizzas/index", data: []))
  end

  def about_us(conn) do
    send_resp(conn, 200, render("pizzas/about_us", data: []))
  end

  def checkout(conn) do
    IO.inspect(Cart.all(conn))

    send_resp(
      conn,
      200,
      render(conn, "pizzas/checkout", carts: Cart.all(conn), pizzas: Pizza.all())
    )
  end

  # Send back menu page when requested with data (all pizzas)
  def menu(conn) do
    send_resp(conn, 200, render(conn, "pizzas/menu", pizzas: Pizza.all()))
  end

  def edit(conn, id) do
    send_resp(
      conn,
      200,
      render(conn, "pizzas/edit", pizza: Pizza.get(id), ingredients: Pizza.ingredients())
    )
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
