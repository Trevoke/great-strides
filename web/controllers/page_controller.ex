defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller


  def index(%{assigns: %{current_user: current_user}} = conn, _params) do
    conn
    |> redirect(to: p_organization_path(conn, :show, current_user.organization_id))
  end


  def index(conn, _params) do
    conn
    |> redirect(to: auth_path(conn, :index))
  end

end
