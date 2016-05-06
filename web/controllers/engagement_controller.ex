defmodule GreatStrides.EngagementController do
  use GreatStrides.Web, :controller

  alias GreatStrides.Engagement
  alias GreatStrides.Diary

  plug :scrub_params, "engagement" when action in [:create, :update]

  def index(conn, _params) do
    engagements = Repo.all(Engagement)
    render(conn, "index.html", engagements: engagements)
  end

  def new(conn, _params) do
    changeset = Engagement.changeset(%Engagement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"engagement" => engagement_params}) do
    changeset = Engagement.changeset(%Engagement{}, engagement_params)

    case Repo.insert(changeset) do
      {:ok, engagement} ->
        conn
        |> put_flash(:info, "Engagement created successfully.")
        |> redirect(to: p_organization_path(conn, :show, engagement.organization_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diary_query = from d in Diary, order_by: [desc: d.inserted_at]
    engagement = Repo.one from e in Engagement,
      where: e.id == ^id,
      preload: [diaries: ^diary_query],
      preload: [:organization, :users]
    render(conn, "show.html", engagement: engagement)
  end

  def edit(conn, %{"id" => id}) do
    engagement = Repo.get!(Engagement, id)
    changeset = Engagement.changeset(engagement)
    render(conn, "edit.html", engagement: engagement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "engagement" => engagement_params}) do
    engagement = Repo.get!(Engagement, id)
    changeset = Engagement.changeset(engagement, engagement_params)

    case Repo.update(changeset) do
      {:ok, engagement} ->
        conn
        |> put_flash(:info, "Engagement updated successfully.")
        |> redirect(to: p_engagement_path(conn, :show, engagement))
      {:error, changeset} ->
        render(conn, "edit.html", engagement: engagement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    engagement = Repo.get!(Engagement, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(engagement)

    conn
    |> put_flash(:info, "Engagement deleted successfully.")
    |> redirect(to: p_engagement_path(conn, :index))
  end
end
