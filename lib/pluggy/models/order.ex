defmodule Pluggy.Order do
  defstruct id: nil,
            pizza_name: nil,
            added_ingredients: [],
            removed_ingredients: [],
            customer: nil,
            is_done: false,
            size: nil,
            gluten: nil

  alias Pluggy.Order

  def all do
    Postgrex.query!(DB, "SELECT * FROM orders", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, pizza_name, added_ingredients, remove_ingredients, customer, is_done, size, gluten] <-
          rows,
        do: %Order{
          id: id,
          pizza_name: pizza_name,
          added_ingredients: added_ingredients,
          removed_ingredients: remove_ingredients,
          customer: customer,
          is_done: is_done,
          size: size,
          gluten: gluten
        }
  end
end
