defmodule GreatStrides.Router do
  use GreatStrides.Web, :router
  require Ueberauth

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

  pipeline :auth do
    Ueberauth.plug "/auth"
  end

  scope "/auth", GreatStrides do
    pipe_through [:browser, :auth]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
    resources "/engagements", EngagementController
  end

  scope "/", GreatStrides do
    pipe_through [:browser] # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GreatStrides do
  #   pipe_through :api
  # end
end
