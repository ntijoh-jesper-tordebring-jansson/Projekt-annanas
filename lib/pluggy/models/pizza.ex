defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", img_path: "", containing_ingredients: "")

  alias Pluggy.Pizza

  def all do
    Postgrex.query!(DB, "SELECT * FROM pizzas", []).rows
    |> to_struct_list
  end

  def get(id) do
    Postgrex.query!(DB, "SELECT id, name, containing_ingredients FROM pizzas WHERE id = $1 LIMIT 1", [String.to_integer(id)]).rows
    |> to_struct
  end

  def ingredients do
    Postgrex.query!(DB, "SELECT * FROM ingredients", []).rows
    |> to_struct_list2
  end

  def to_struct([[id, name, containing_ingredients]]) do
    %Pizza{id: id, name: name, containing_ingredients: containing_ingredients}
  end

  def to_struct_list(rows) do
    for [id, name, img_path, containing_ingredients] <- rows,
        do: %Pizza{
          id: id,
          name: name,
          img_path: img_path,
          containing_ingredients: containing_ingredients
        }
  end

  def to_struct_list2(rows) do
    for [id, name] <- rows,
        do: %Pizza{
          id: id,
          name: name
        }
  end
end
