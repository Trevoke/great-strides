defmodule GreatStrides.AuthController do
  use GreatStrides.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias GreatStrides.Organization
  alias GreatStrides.User

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
        ensure_db_entries_exist(conn, user)
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  defp ensure_db_entries_exist(conn, authed_user) do
    [_, domain] = String.split(authed_user.email, "@")
    query = from org in Organization,
    where: org.domain == ^domain

    org = Repo.one(query)
    unless org do
      org = Repo.insert(%Organization{domain: domain})
    end

    query = from u in User,
    where: u.username == ^authed_user.email
    user = Repo.one(query)
    unless user do
      Repo.insert(%User{username: authed_user.email,
                        organization_id: org.id})
    end
    conn
  end
end
