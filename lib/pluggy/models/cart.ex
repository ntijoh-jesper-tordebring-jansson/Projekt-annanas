defmodule Pluggy.Cart do
  def add_to_cart(id) do

    Postgrex.query!(DB, "INSERT INTO cart (uuid, pizza_id, gluten, size) VALUES($1, $2,$3, $4,)", id )
  end

  def all(uuid) do
    
  end
end
