defmodule Pluggy.Template do
  alias Pluggy.Pizza
  alias Pluggy.Cart

  def render(conn, file, data \\ [], layout \\ true) do
    case layout do
      true ->
        EEx.eval_file("templates/layout.eex",
          template: EEx.eval_file("templates/#{file}.eex", data),
          pizzas: Pizza.all(),
          carts: Cart.all(conn)
        )

      false ->
        EEx.eval_file("templates/#{file}.eex", data)
    end
  end
end
