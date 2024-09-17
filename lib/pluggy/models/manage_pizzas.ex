defmodule Pluggy.Manage_Pizzas do
  defstruct(id: "", name: "", img_path: "", containing_ingredients: "")

  alias Pluggy.Manage_Pizzas

  def all do
    Postgrex.query!(DB, "SELECT * FROM pizzas", []).rows
    |> to_struct_list
  end

  def to_struct_list(rows) do
    for [id, name, img_path, containing_ingredients] <- rows,
      do: %Manage_Pizzas{
          id: id,
          name: name,
          img_path: img_path,
          containing_ingredients: containing_ingredients,
      }
  end

  def remove_ingredients(name) do
    pizzas = Manage_Pizzas.all()
    for pizza <- pizzas do
      if name in pizza.containing_ingredients do
        Postgrex.query!(DB, "DELETE FROM pizzas WHERE id = #{pizza.id}", [])
      end
    end
  end

  def remove(name) do
    Postgrex.query!(DB, "DELETE FROM pizzas WHERE name = '#{name}'", [])
  end

  def add(name, img_path, containing_ingredients) do



    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", [name, img_path, containing_ingredients], pool: DBConnection.ConnectionPool)

    # Postgrex.query!(DB, "INSERT INTO pizzas (name, img_path, containing_ingredients) VALUES ('#{name}', '#{img_path}', '#{containing_ingredients}')", [])
  end

  def default do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "Create TABLE pizzas (id SERIAL, name VARCHAR(255) NOT NULL, img_path VARCHAR(255) NOT NULL, containing_ingredients JSONB NOT NULL)", [], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Margherita", "/img/pizzas/margherita.svg", ["Tomatsås", "Mozzarella", "Basilika"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Marinara", "/img/pizzas/marinara.svg", ["Tomatsås"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Prosciutto e funghi", "/img/pizzas/prosciutto-e-funghi.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro stagiono", "/img/pizzas/quattro-stagioni.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka", "Oliver"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Capricciosa", "/img/pizzas/capricciosa.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro formaggi", "/img/pizzas/quattro-formaggi.svg", ["Tomatsås", "Mozzarella", "Parmesan", "Pecorino", "Gorgonzola"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Ortolana", "/img/pizzas/ortolana.svg", ["Tomatsås", "Mozzarella", "Paprika", "Aubergine", "Zucchini"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Diavola", "/img/pizzas/diavola.svg", ["Tomatsås", "Mozzarella", "Salami", "Paprika", "Chili"]], pool: DBConnection.ConnectionPool)
  end

end
