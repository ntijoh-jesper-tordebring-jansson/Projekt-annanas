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

  def add_to_cart(id) do
    Postgrex.query!(
      DB,
      "INSERT INTO cart (uuid, pizza_name, gluten, size) VALUES($1, $2,$3, $4,)",
      id
    )
  end

  def all(conn) do
    Postgrex.query!(DB, "SELECT * FROM carts WHERE uuid = $1", [conn.private.plug_session["cart"]]).rows
    |> to_struct_list
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
