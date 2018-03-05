defmodule TeetarWeb.Router do
  use TeetarWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TeetarWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/netizens", NetizenController, except: [:new, :edit]
    post "/check-code", CodeController, :show
    post "/login", UserController, :auth
    get "/newsfeed", PostController, :newsfeed
    get "/users/:id/verify", UserController, :verify
  end
end
