defmodule Pluggy.UserController do
  import Plug.Conn, only: [send_resp: 3]

  ## Login to admin page ##
  def login(conn, params) do

    # Extract entered username and password from request
    username = params["username"]
    password = params["password"]


    result =
      Postgrex.query!(DB, "SELECT id, hash_psw FROM users WHERE username = $1", [username],
        pool: DBConnection.ConnectionPool
      )

    case result.num_rows do
      # no user with that username
      0 ->
        redirect(conn, "/admin")
      # user with that username exists
      _ ->
        [[id, hash_psw]] = result.rows

        # Check if password is correct
        if Bcrypt.verify_pass(password, hash_psw) do
          Plug.Conn.put_session(conn, :user_id, id)
          |> redirect("/admin/orders") #skicka vidare modifierad conn
        else
          redirect(conn, "/admin")
        end
    end
  end

  def logout(conn) do
    Plug.Conn.configure_session(conn, drop: true) #tömmer sessionen
    |> redirect("/fruits")
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
