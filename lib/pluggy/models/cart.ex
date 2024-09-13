defmodule Pluggy.Cart do
  def add_to_cart(id) do
    
    Postgrex.query!(DB, "INSERT INTO cart (uuid, pizza_id, add_ingredients, remove_ingredients) VALUES($1, $2,$3, $4)", id )
  end
end
