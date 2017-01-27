defmodule Digester.Router do
  use Digester.Web, :router

  forward "/ql", Absinthe.Plug, schema: Digester.Schema

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Digester.Plugs.AuthenticateHost
  end


  scope "/", Digester do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Digester do
    pipe_through :api

    # Singular endpoint for catching logs
    post "/logs", Logs.LogController, :create

    resources "/hosts", HostController do
      scope "/logs", Logs do
        resources "/cron", CronController
        resources "/audispd", AudispdController
      end
    end
  end
end
