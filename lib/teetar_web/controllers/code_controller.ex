defmodule TeetarWeb.CodeController do
  use TeetarWeb, :controller

  alias Teetar.Code_generator
  alias Teetar.Code_generator.Code

  action_fallback TeetarWeb.FallbackController

  def show(conn, %{"user" => user_params}) do
    random_code = Code_generator.get_code(user_params["username"])
    code = user_params["code"]

    if random_code == code do
      
    end
  end
end
