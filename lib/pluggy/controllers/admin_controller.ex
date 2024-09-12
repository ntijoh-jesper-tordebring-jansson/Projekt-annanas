defmodule Pluggy.AdminController do

  require IEx

  alias Pluggy.Admin
  # alias Pluggy.User
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def admin(conn) do
    send_resp(conn, 200, render("pizzas/admin",[]))
  end

  def orders(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    case session_user do
      nil -> redirect(conn, "/admin")
      _ -> send_resp(conn, 200, render("Pizzas/orders", order: Admin.all(), layout: false))
    end
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
