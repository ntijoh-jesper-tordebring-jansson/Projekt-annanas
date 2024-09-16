defmodule Pluggy.CartController do
  require IEx

  alias Pluggy.Cart
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def add(conn, params) do
    Cart.add_cart(conn, params)
    redirect(conn, "/menu")
  end

  def add_edit(conn, id, params) do
    Cart.add_edit_cart(conn, id, params)
    redirect(conn, "/menu")
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
