defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run "app.start"
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS ingredients", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables") 
    Postgrex.query!(DB, "Create TABLE pizzas (id SERIAL, name VARCHAR(255) NOT NULL, img_path VARCHAR(255) NOT NULL, containing_ingredients JSONB NOT NULL)", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "Create TABLE ingredients (id SERIAL, name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "Create TABLE orders (id SERIAL, pizza_name VARCHAR(255) NOT NULL, added_ingredients VARCHAR(255) NOT NULL, removed_ingredients VARCHAR(255) NOT NULL, customer VARCHAR(255) NOT NULL, done BOOLEAN)", [], pool: DBConnection.ConnectionPool)
  end

  defp seed_data() do
    IO.puts("Seeding data")
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Margherita", "/img/pizzas/margherita.svg", ["Tomatsås", "Mozzarella", "Basilika"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Marinara", "/img/pizzas/marinara.svg", ["Tomatsås"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Prosciutto e funghi", "/img/pizzas/prosciutto-e-funghi.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro stagiono", "/img/pizzas/quattro-stagioni.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka", "Oliver"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Capricciosa", "/img/pizzas/capricciosa.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro formaggi", "/img/pizzas/quattro-formaggi.svg", ["Tomatsås", "Mozzarella", "Parmesan", "Pecorino", "Gorgonzola"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Ortolana", "/img/pizzas/ortolana.svg", ["Tomatsås", "Mozzarella", "Paprika", "Aubergine", "Zucchini"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Diavola", "/img/pizzas/diavola.svg", ["Tomatsås", "Mozzarella", "Salami", "Paprika", "Chili"]], pool: DBConnection.ConnectionPool)

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
