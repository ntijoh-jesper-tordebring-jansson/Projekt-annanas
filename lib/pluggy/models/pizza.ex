defmodule Pluggy.Pizza do
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
