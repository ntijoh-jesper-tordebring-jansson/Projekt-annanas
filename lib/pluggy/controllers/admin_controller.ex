defmodule Pluggy.AdminController do
  require IEx

  alias Pluggy.Admin
  alias Pluggy.Manage_Pizzas
  alias Pluggy.Manage_Ingredients
  # import Pluggy.Template
  import Pluggy.Template, only: [render: 3, render: 2, render: 4]
  import Plug.Conn, only: [send_resp: 3]

  def admin(conn) do
    send_resp(conn, 200, render(conn, "pizzas/admin", []))
  end

  def orders(conn) do
    if conn.private.plug_session["user_id"] == nil do
      redirect(conn, "/admin")
    else
      send_resp(conn, 200, render(conn, "pizzas/orders", [orders: Admin.all()], "admin_layout"))
    end
  end

  def pizzas(conn) do
    send_resp(conn, 200, render(conn, "pizzas/manage_pizzas", [pizzas: Manage_Pizzas.all(), ingredients: Manage_Ingredients.all()], "admin_layout"))
  end

  def remove_pizza(conn, params) do
    pizza = params["list-input"]
    Manage_Pizzas.remove(pizza)
    redirect(conn, "/admin/pizzas")
  end

  def add_pizza(conn, params) do
    regex = ~r/^ingredients/

    %Plug.Upload{filename: filename, path: temp_path} = params["file-input"]

    dest_path = "/priv/static/img/pizzas/#{filename}"

    File.cp(temp_path, dest_path)

    file_path = "/img/pizzas/#{filename}"

    name = params["text-input"]

    ingredients =
      params
      |> Enum.filter(fn {key, _value} -> Regex.match?(regex, key) end)
      |> Enum.map(fn {_key, value} -> value end)

    Manage_Pizzas.add(name, file_path, ingredients)

    redirect(conn, "/admin/pizzas")
  end

  def default_pizza(conn) do
    Manage_Pizzas.default()
    redirect(conn, "/admin/pizzas")
  end

  def ingredients(conn) do
    send_resp(conn, 200, render(conn, "pizzas/manage_ingredients", [ingredients: Manage_Ingredients.all()], "admin_layout"))
  end

  def add_ingredient(conn, params) do
    ingredients = params["text-input"]
    Manage_Ingredients.add(ingredients)
    redirect(conn, "/admin/ingredients")
  end

  def remove_ingredient(conn, params) do
    ingredients = params["list-input"]
    Manage_Ingredients.remove(ingredients)
    Manage_Pizzas.remove_ingredients(ingredients)
    redirect(conn, "/admin/ingredients")
  end

  def default_ingredient(conn) do
    Manage_Ingredients.default()
    redirect(conn, "/admin/ingredients")
  end

  def done(conn, id) do
    Admin.is_done(id)
    redirect(conn, "/admin/orders")
  end

  def not_done(conn, id) do
    Admin.is_not_done(id)
    redirect(conn, "/admin/orders")
  end

  def delete(conn, id) do
    Admin.delete(id)
    redirect(conn, "/admin/orders")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
