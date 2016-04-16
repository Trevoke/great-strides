defmodule GreatStrides.AuthController do
  use GreatStrides.Web, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers

  require IEx
  require Logger

  @login_method Application.get_env(:great_strides, :login_method)

  def index(conn, _params) when @login_method == :form do
    render conn, "dev_login.html"
  end

  def index(conn, _params) when @login_method == :oauth do
    render conn, "login.html"
  end


  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def callback(conn, %{"provider" => "dev"} = params) do
    IEx.pry
    conn
    |> redirect(to: "/")
  end

end
