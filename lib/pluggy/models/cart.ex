defmodule Pluggy.Cart do
  defstruct(
    id: nil,
    uuid: "",
    pizza_name: "",
    add_ingredients: "",
    remove_ingredients: "",
    size: "",
    gluten: ""
  )

  alias Pluggy.Cart

  def all(conn) do
    Postgrex.query!(DB, "SELECT * FROM carts WHERE uuid = $1", [conn.private.plug_session["cart"]]).rows
    |> to_struct_list
  end

  def add_cart(conn, params) do
    IO.puts("Adding to cart")

    ## Get pizza_id from params ##
    pizza_name = params["pizza_name"]

    ## Get cart_id from session cookie ##
    cart_id = conn.private.plug_session["cart"]

    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)
    Postgrex.query!(
      DB,
      "INSERT INTO carts (uuid, pizza_name, add_ingredients, remove_ingredients, gluten, size) VALUES($1, $2,$3, $4, $5, $6)",
      [
        cart_id,
        pizza_name,
        "",
        "",
        false,
        true
      ]
    )
  end

  def add_edit_cart(conn, id, params) do
    IO.puts("Adding to cart")

    ## Get cart_id from session ##
    cart_id = conn.private.plug_session["cart"]

    pizza_name = params["pizza_name"]

    pizza_ingredients =
      Postgrex.query!(DB, "SELECT containing_ingredients FROM pizzas WHERE id = $1 LIMIT 1", [
        String.to_integer(id)
      ]).rows

    pizza_ingredients2 = hd(hd(pizza_ingredients))
    add_ingredients = params["ingredients"] -- pizza_ingredients2
    remove_ingredients = pizza_ingredients2 -- params["ingredients"]

    # ## Update cart in DB ##
    # Cart.update_cart(new_cart)
    Postgrex.query!(
      DB,
      "INSERT INTO carts (uuid, pizza_name, add_ingredients, remove_ingredients, gluten, size) VALUES($1, $2,$3, $4, $5, $6)",
      [
        cart_id,
        pizza_name,
        add_ingredients,
        remove_ingredients,
        case params["gluten"] do
          "glutenfri" -> true
          _ -> false
        end,
        case params["pizza_size"] do
          "familj" -> false
          _ -> true
        end
      ]
    )
  end

  def to_struct_list(rows) do
    for [id, uuid, pizza_name, add_ingredients, remove_ingredients, size, gluten] <- rows,
        do: %Cart{
          id: id,
          uuid: uuid,
          pizza_name: pizza_name,
          add_ingredients: add_ingredients,
          remove_ingredients: remove_ingredients,
          size: size,
          gluten: gluten
        }
  end
end
