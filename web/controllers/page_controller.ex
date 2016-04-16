defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  def index(conn, _params) do
    if current_user = get_session(conn, :current_user) do
      conn
      |> redirect to: p_organization_path(conn, :show, current_user.organization_id)
    else
      conn
      |> redirect to: auth_path(conn, :index)
    end
  end
end
