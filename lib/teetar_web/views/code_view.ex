defmodule TeetarWeb.CodeView do
  use TeetarWeb, :view
  alias TeetarWeb.CodeView

  def render("index.json", %{codes: codes}) do
    %{data: render_many(codes, CodeView, "code.json")}
  end

  def render("show.json", %{code: code}) do
    %{data: render_one(code, CodeView, "code.json")}
  end

  def render("code.json", %{code: code}) do
    %{id: code.id,
      username: code.username,
      random_code: code.random_code}
  end
end
