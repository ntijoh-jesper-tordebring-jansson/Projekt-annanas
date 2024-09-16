defmodule Pluggy.Cart do
  defstruct(
    id: nil,
    uuid: "",
    pizza_id: "",
    add_ingridients: "",
    remove_ingridients: "",
    size: "",
    gluten: ""
  )

  alias Pluggy.Cart

  def add_to_cart(id) do
    Postgrex.query!(
      DB,
      "INSERT INTO cart (uuid, pizza_id, gluten, size) VALUES($1, $2,$3, $4,)",
      id
    )
  end

  def all(conn) do
    Postgrex.query!(DB, "SELECT * FROM carts WHERE uuid = $1", [conn.private.plug_session["cart"]]).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, uuid, pizza_id, add_ingridients, remove_ingridients, size, gluten] <- rows,
        do: %Cart{
          id: id,
          uuid: uuid,
          pizza_id: pizza_id,
          add_ingridients: add_ingridients,
          remove_ingridients: remove_ingridients,
          size: size,
          gluten: gluten
        }
  end
end
