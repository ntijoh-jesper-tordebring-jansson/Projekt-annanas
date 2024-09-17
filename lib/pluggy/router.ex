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

  # Admin - manage pizzas page
  get("/admin/pizzas", do: AdminController.pizzas(conn))

  # Admin - manage ingredients page
  get("/admin/ingredients", do: AdminController.ingredients(conn))



  ## POST-requests ##

  # Admin - login
  post("/users/login", do: UserController.login(conn, conn.body_params))

  # Admin - logout
  post("/users/logout", do: UserController.logout(conn))

  # Edit pizza commit
  post("/menu/edit/:id", do: PizzaController.update(conn, id, conn.body_params))

  # Add pizza
  post("/menu/add", do: CartController.add(conn, conn.body_params))

  # Set an orders state to done on admin page
  post("/admin/orders/done/:id", do: AdminController.done(conn, id))

  # Set an orders state to not done on admin page
  post("/admin/orders/not-done/:id", do: AdminController.not_done(conn, id))

  # Delete an orders on admin page
  post("/admin/orders/delete/:id", do: AdminController.delete(conn, id))

  # Add ingredient
  post("/admin/ingredients/add", do: AdminController.add_ingredient(conn, conn.body_params))

  # Remove ingredient
  post("/admin/ingredients/remove", do: AdminController.remove_ingredient(conn, conn.body_params))

  # Default ingredient
  post("/admin/ingredients/defualt", do: AdminController.default_ingredient(conn))

  # Remove pizza
  post("/admin/pizza/remove", do: AdminController.remove_pizza(conn, conn.body_params))

  # Add pizza
  post("/admin/pizza/add", do: AdminController.add_pizza(conn, conn.body_params))

  # Default pizza
  post("/admin/pizzas/defualt", do: AdminController.default_pizza(conn))







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
