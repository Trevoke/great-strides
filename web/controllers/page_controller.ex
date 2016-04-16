defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  def index(conn, _params) do
    user = get_session(conn, :user)
    if user do
      conn
      |> redirect(to: p_organization_path(conn, :show, user.organization_id))
    else do
      conn
      |> redirect(to: auth_path(conn, :index))
    end
  end

end
