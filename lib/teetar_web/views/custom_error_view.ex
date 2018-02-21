defmodule TeetarWeb.CustomErrorView do
  use TeetarWeb, :view

  def render("errors.json", %{errors: errors}) do
    %{errors: render_many(errors, __MODULE__, "error.json", as: :error)}
  end

  def render("show.json", %{error: error}) do
    %{errors: render_one(error, __MODULE__, "error.json")}
  end

  def render("error.json", %{error: error}) do
    %{
      title: error.title,
      detail: error.detail
    }
  end
end
