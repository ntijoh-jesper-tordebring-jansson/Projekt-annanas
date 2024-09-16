defmodule Pluggy.Router do
  use Plug.Router
  use Plug.Debugger

  alias Pluggy.PizzaController
  alias Pluggy.UserController
  alias Pluggy.AdminController
  alias Pluggy.CartController

  plug(Plug.Static, at: "/", from: :pluggy)
  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_my_app_session",
    encryption_salt: "cookie store encryption salt",
    signing_salt: "cookie store signing salt",
    log: :debug
  )

  plug(:fetch_session)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:match)
  plug(:dispatch)

  ## GET-requests ##

  # Index page
  get("/", do: PizzaController.index(conn))

  # Menu page
  get("/menu", do: PizzaController.menu(conn))

  # Menu - edit page
  get("/menu/edit/:id", do: PizzaController.edit(conn, id))

  # Checkout cart page
  get("/checkout", do: PizzaController.checkout(conn))

  # Admin page
  get("/admin", do: AdminController.admin(conn))

  # Admin - orders page
  get("/admin/orders", do: AdminController.orders(conn))

  ## POST-requests ##

  # Admin - login
  post("/users/login", do: UserController.login(conn, conn.body_params))

  # Admin - logout
  post("/users/logout", do: UserController.logout(conn))

  # Edit pizza commit
  post("/menu/edit/:id", do: CartController.add_edit(conn, id, conn.body_params))

  post("/menu/add", do: CartController.add(conn, conn.body_params))

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp put_secret_key_base(conn, _) do
    put_in(
      conn.secret_key_base,
      "M7K/Odlu5j46AZslaMS+Xm02LvTemMXnRcPmBVqnzM1rxKW7JFR9I5o8tw6dl8fYUJLT1ie/nBejkXNU1VwA6w=="
    )
  end
end
