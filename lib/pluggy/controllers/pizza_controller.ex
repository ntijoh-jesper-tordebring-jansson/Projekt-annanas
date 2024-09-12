defmodule Pluggy.PizzaController do
  require IEx

  alias Pluggy.Pizza
  # alias Pluggy.User
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn) do
    send_resp(conn, 200, render("pizzas/index", data: [], layout: true))
  end

  def checkout(conn) do
    send_resp(conn, 200, render("pizzas/checkout", data: [], layout: true))
  end

  def menu(conn) do
    send_resp(conn, 200, render("pizzas/menu", pizzas: Pizza.all(), layout: true))
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
