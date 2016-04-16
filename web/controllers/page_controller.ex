defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  require Logger

  def index(conn, _params) do
    user = get_session(conn, :user_id)
    Logger.info "INSIDE / #{user}"
    if user do
      conn
      |> redirect(to: p_organization_path(conn, :show, 1))
    else
      conn
      |> redirect(to: auth_path(conn, :index))
    end
  end

end
