defmodule StarWars.Router do
  use StarWars.Web, :router

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

  pipeline :graphql do
    plug GraphqlLogger
  end

  scope "/", StarWars do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/graphql" do
    pipe_through :graphql
    get "/", Absinthe.Plug, schema: StarWars.Schema
    post "/", Absinthe.Plug, schema: StarWars.Schema
  end

  if Mix.env == :dev do
    forward "/docs", Absinthe.Plug.GraphiQL, schema: StarWars.Schema
  end
end
