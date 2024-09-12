defmodule Pluggy.Pizza do

  defstruct(id: nil, name: "", img_path: "", containing_ingredients: "")

  alias Pluggy.Pizza

  def all do
    Postgrex.query!(DB, "SELECT * FROM pizzas", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, name, img_path, containing_ingredients] <- rows, do: %Pizza{id: id, name: name, img_path: img_path, containing_ingredients: containing_ingredients}
  end

end
