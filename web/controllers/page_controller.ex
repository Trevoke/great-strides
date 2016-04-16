defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  def index(conn, _params) do
    user = get_session(conn, :user_id)
    if user do
      conn
      |> redirect(to: p_organization_path(conn, :show, 1))
    else
      conn
      |> redirect(to: auth_path(conn, :index))
    end
  end

end
