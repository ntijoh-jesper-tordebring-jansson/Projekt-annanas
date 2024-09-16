defmodule Pluggy.Admin do
  defstruct(id: nil, pizza_name: "", added_ingredients: "", removed_ingredients: "", customer: "", is_done: "")

  alias Pluggy.Admin


  def all do
    Postgrex.query!(DB, "SELECT * FROM orders", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, pizza_name, added_ingredients, removed_ingredients, customer, is_done] <- rows,
      do: %Admin{
          id: id,
          pizza_name: pizza_name,
          added_ingredients: added_ingredients,
          removed_ingredients: removed_ingredients,
          customer: customer,
          is_done: is_done
      }
  end

end
