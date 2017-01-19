defmodule Digester.Router do
  use Digester.Web, :router

  forward "/", Absinthe.Plug, schema: Digester.Schema

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", Digester do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Digester do
    pipe_through :api

    resources "/logs", LogController
    resources "/hosts", HostController
  end
end
