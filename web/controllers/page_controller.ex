defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  alias GreatStrides.User

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Repo.one from u in User, where: u.id == ^user_id
      conn
      |> redirect(to: p_organization_path(conn, :show, user.organization_id))
    else
      conn
      |> redirect(to: auth_path(conn, :index))
    end
  end

end
