defmodule Pluggy.PizzaController do
  require IEx

  alias Pluggy.Pizza
  # alias Pluggy.User
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn) do
    send_resp(conn, 200, render("pizzas/index", []))
  end

  def checkout(conn) do
    send_resp(conn, 200, render("pizzas/checkout", []))
  end

  def admin(conn) do
    send_resp(conn, 200, render("pizzas/admin",[]))
  end

  def menu(conn) do
    send_resp(conn, 200, render("pizzas/menu", data: [], layout: true))
  end

  def orders(conn) do
    if 0 == 0 do
      send_resp(conn, 200, render("Pizzas/orders", data: [], layout: false))
    else
      redirect(conn, "/admin")
    end
  end

  def admin_login_check(conn, params) do
    if Pizza.admin_validate(params) do
      redirect(conn, "/admin/orders")
    else
      redirect(conn, "/admin")
    end
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
