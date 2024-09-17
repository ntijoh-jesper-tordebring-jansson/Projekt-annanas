defmodule Pluggy.Admin do
  defstruct(id: "", pizza_name: "", added_ingredients: "", removed_ingredients: "", customer: "", is_done: "", size: "", gluten: "")

  alias Pluggy.Admin


  def all do
    Postgrex.query!(DB, "SELECT * FROM orders ORDER BY is_done DESC", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, pizza_name, added_ingredients, removed_ingredients, customer, is_done, size, gluten] <- rows,
      do: %Admin{
          id: id,
          pizza_name: pizza_name,
          added_ingredients: added_ingredients,
          removed_ingredients: removed_ingredients,
          customer: customer,
          is_done: is_done,
          size: size,
          gluten: gluten
      }
  end

  def is_done(id) do
    Postgrex.query!(DB, "UPDATE orders SET is_done = true WHERE id = '#{id}'", [])
  end

  def is_not_done(id) do
    Postgrex.query!(DB, "UPDATE orders SET is_done = false WHERE id = '#{id}'", [])
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM orders WHERE id = '#{id}'", [])
  end

end
