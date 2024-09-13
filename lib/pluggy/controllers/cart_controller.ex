defmodule Pluggy.CartController do

  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]
  def add(conn, id) do
    
    redirect(conn, "/menu")
  end

   defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
