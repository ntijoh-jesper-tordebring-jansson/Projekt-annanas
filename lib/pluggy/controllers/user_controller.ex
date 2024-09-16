defmodule Pluggy.UserController do
  import Plug.Conn, only: [send_resp: 3]

  ## Login to admin page ##
  def login(conn, params) do

    # Extract entered username and password from request
    username = params["username"]
    password = params["password"]

    # Get the hashed password of the current user from the database
    result = Postgrex.query!(DB, "SELECT id, hashed_password FROM users WHERE username = $1", [username])

    # Process the login
    case result.num_rows do

      # If theres no user with this username in database
      0 ->

        # Redirect back to admin login page
        redirect(conn, "/admin")

      # If a user with this username is in database
      _ ->

        # Define id and hashed_password from the database
        [[id, hashed_password]] = result.rows

        # Check if the entered password is correct by matching it with the encrypted password in database
        if Bcrypt.verify_pass(password, hashed_password) do

          # Give back a session id if password is correct
          Plug.Conn.put_session(conn, :user_id, id)

          # Send user to the orders page with the updated conn value
          |> redirect("/admin/orders")

        else

          # If the password is incorrect, redirect back to login page
          redirect(conn, "/admin")

        end

    end

  end

  ## Log out from the admin page ##
  def logout(conn) do

    # Empty the session
    Plug.Conn.configure_session(conn, drop: true)

    # Redirect back to the login page
    |> redirect("/admin")
  end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
