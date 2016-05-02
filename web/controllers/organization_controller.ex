defmodule GreatStrides.OrganizationController do
  use GreatStrides.Web, :controller

  alias GreatStrides.Organization
  alias GreatStrides.Engagement

  plug :scrub_params, "organization" when action in [:create, :update]

  def index(conn, _params) do
    organizations = Repo.all(Organization)
    render(conn, "index.html", organizations: organizations)
  end

  def new(conn, _params) do
    changeset = Organization.changeset(%Organization{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    changeset = Organization.changeset(%Organization{}, organization_params)

    case Repo.insert(changeset) do
      {:ok, _organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: p_organization_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Repo.get!(Organization, id, preload: [:engagements])
    organization = Repo.preload organization, :engagements
    new_engagement = Engagement.changeset(%Engagement{organization_id: id})
    conn
    |> render("show.html", organization: organization, new_engagement: new_engagement)
  end

  def edit(conn, %{"id" => id}) do
    organization = Repo.get!(Organization, id)
    changeset = Organization.changeset(organization)
    render(conn, "edit.html", organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Repo.get!(Organization, id)
    changeset = Organization.changeset(organization, organization_params)

    case Repo.update(changeset) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: p_organization_path(conn, :show, organization))
      {:error, changeset} ->
        render(conn, "edit.html", organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Repo.get!(Organization, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: p_organization_path(conn, :index))
  end
end
