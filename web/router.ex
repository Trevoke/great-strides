defmodule GreatStrides.Router do
  use GreatStrides.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GreatStrides.Auth, repo: GreatStrides.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :mail do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  end

  scope "/auth", GreatStrides do
    pipe_through [:browser]

    get "/", AuthController, :index
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", GreatStrides do
    pipe_through [:browser]

    get "/", PageController, :index
  end

  scope "/p", GreatStrides, as: :p do
    pipe_through [:browser, :authenticate_user]

    resources "/engagements", EngagementController
    resources "/organizations", OrganizationController
  end

  scope "/mail", GreatStrides do
    pipe_through :mail
    post "/", MailController, :create
  end

end
