defmodule GreatStrides.UserController do
  use GreatStrides.Web, :controller

  alias GreatStrides.User
  require IEx

  def update_engagement(
        conn,
        %{
          "org_id" => organization_id,
          "user" => %{
            "engagement_id" => engagement_id,
            "id" => id
          }}) do

    user = Repo.get!(User, id)
    changeset = User.changeset(user,
      %{
        "engagement_id" => engagement_id,
        "organization_id" => organization_id
      })

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User assigned successfully.")
        |> redirect(to: p_organization_path(conn, :show, organization_id))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to assign user.")
        |> redirect(to: p_organization_path(conn, :show, organization_id))
    end
  end

end
