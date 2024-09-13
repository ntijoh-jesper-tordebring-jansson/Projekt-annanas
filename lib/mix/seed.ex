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

    ## Drop table pizzas ##
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)

    ## Drop table ingredients ##
    Postgrex.query!(DB, "DROP TABLE IF EXISTS ingredients", [], pool: DBConnection.ConnectionPool)

    ## Drop table orders ##
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [], pool: DBConnection.ConnectionPool)
    ## drop table carts ##
    Postgrex.query!(DB, "DROP TABLE IF EXISTS carts", [], pool: DBConnection.ConnectionPool)
    ## Drop table users ##
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)

  end

  defp create_tables() do
    IO.puts("Creating tables")

    ## Create table pizzas ##
    Postgrex.query!(DB, "Create TABLE pizzas (id SERIAL, name VARCHAR(255) NOT NULL, img_path VARCHAR(255) NOT NULL, containing_ingredients JSONB NOT NULL)", [], pool: DBConnection.ConnectionPool)

    ## Create table ingredients ##
    Postgrex.query!(DB, "Create TABLE ingredients (id SERIAL, name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
    ## Create table orders ##
    Postgrex.query!(DB, "Create TABLE orders (id SERIAL, pizza_name VARCHAR(255) NOT NULL, added_ingredients JSONB NOT NULL, removed_ingredients JSONB NOT NULL, customer VARCHAR(255) NOT NULL, is_done BOOLEAN, size BOOLEAN NOT NULL, gluten BOOLEAN NOT NULL)", [], pool: DBConnection.ConnectionPool)
    ## Create table carts ##
    Postgrex.query!(DB, "Create TABLE carts (id SERIAL, uuid VARCHAR(255) NOT NULL, pizza_id VARCHAR(255) NOT NULL, add_ingredients JSONB NOT NULL, remove_ingredients JSONB NOT NULL)", [], pool: DBConnection.ConnectionPool)

    ## Create table users ##
    Postgrex.query!(DB, "Create TABLE users (id SERIAL, username VARCHAR(255) NOT NULL, hashed_password VARCHAR(255) NOT NULL, role VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)

  end

  defp seed_data() do
    IO.puts("Seeding data")

    ## Seeding default pizzas ##
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Margherita", "/img/pizzas/margherita.svg", ["Tomatsås", "Mozzarella", "Basilika"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Marinara", "/img/pizzas/marinara.svg", ["Tomatsås"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Prosciutto e funghi", "/img/pizzas/prosciutto-e-funghi.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro stagiono", "/img/pizzas/quattro-stagioni.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka", "Oliver"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Capricciosa", "/img/pizzas/capricciosa.svg", ["Tomatsås", "Mozzarella", "Skinka", "Svamp", "Kronärtskocka"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Quattro formaggi", "/img/pizzas/quattro-formaggi.svg", ["Tomatsås", "Mozzarella", "Parmesan", "Pecorino", "Gorgonzola"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Ortolana", "/img/pizzas/ortolana.svg", ["Tomatsås", "Mozzarella", "Paprika", "Aubergine", "Zucchini"]], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img_path, containing_ingredients) VALUES($1, $2, $3)", ["Diavola", "/img/pizzas/diavola.svg", ["Tomatsås", "Mozzarella", "Salami", "Paprika", "Chili"]], pool: DBConnection.ConnectionPool)

    ## Seeding default ingredients ##
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

    ## Seeding default users ##
    Postgrex.query!(DB, "INSERT INTO users(username, hashed_password, role) VALUES($1, $2, $3)", ["Tony", Bcrypt.hash_pwd_salt("a"), "admin"], pool: DBConnection.ConnectionPool)



    # Temporary for dev
    Postgrex.query!(DB, "INSERT INTO orders(pizza_name, added_ingredients, removed_ingredients, customer, is_done, size, gluten) VALUES($1, $2, $3, $4, $5, $6, $7)", ["Diavola", ["Annanas", "Chili"], ["Tomatsås", "Mozzarella"], "Daniel", false, false, true], pool: DBConnection.ConnectionPool)
  end

end
