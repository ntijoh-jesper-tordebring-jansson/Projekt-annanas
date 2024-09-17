defmodule Pluggy.Manage_Ingredients do
  defstruct(id: "", name: "")

  alias Pluggy.Manage_Ingredients

  def all do
    Postgrex.query!(DB, "SELECT * FROM ingredients", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, name] <- rows,
      do: %Manage_Ingredients{
          id: id,
          name: name,
      }
  end

  def add(name) do
    Postgrex.query!(DB, "INSERT INTO ingredients (name) VALUES ('#{name}')", [])
  end

  def remove(name) do
    Postgrex.query!(DB, "DELETE FROM ingredients WHERE name = '#{name}'", [])
  end

  def default() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS ingredients", [], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "Create TABLE ingredients (id SERIAL, name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Tomatsås"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Mozzarella"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Basilika"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Skinka"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Svamp"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Kronärtskocka"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Oliver"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Parmesan"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Pecorino"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Gorgonzola"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Paprika"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Aubergine"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Zucchini"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Salami"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Chili"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO ingredients(name) VALUES($1)", ["Annanas"], pool: DBConnection.ConnectionPool)
  end

end
