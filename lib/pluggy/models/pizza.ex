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







  @users %{
    "Tony123!" => Bcrypt.hash_pwd_salt("secret_password")
  }


  def admin_validate(params) do
    username = params["username"]
    password = params["password"]


    case @users[username] do
      nil ->
        false
      stored_hash ->
        if Bcrypt.verify_pass(password, stored_hash) do
          true
        else
          false
        end
    end
  end
end
