defmodule Pluggy.Template do
  def render(file, data \\ [], layout \\ "default") do
    cond do
      layout == "default" -> EEx.eval_file("templates/layout.eex", template: EEx.eval_file("templates/#{file}.eex", data))
      layout == "admin_layout" -> EEx.eval_file("templates/admin_layout.eex", template: EEx.eval_file("templates/#{file}.eex", data))
    end
  end
end
