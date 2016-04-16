defmodule UserFromAuth do
#  use GreatStrides.Web, :model
  import Ecto
  import Ecto.Query, only: [from: 2]
  alias GreatStrides.Repo
  @moduledoc """
  Retrieve the user information from an auth request
  """

  alias Ueberauth.Auth
  alias GreatStrides.User
  alias GreatStrides.Organization

  def find_or_create(%Auth{provider: :identity} = auth) do
    case validate_pass(auth.credentials) do
      :ok ->
        {:ok, basic_info(auth)}
      {:error, reason} -> {:error, reason}
    end
  end

  def find_or_create(%Auth{} = auth) do
    {:ok, basic_info(auth)}
  end

  defp basic_info(auth) do
    %{id: auth.uid,
      name: name_from_auth(auth),
      avatar: auth.info.image,
      email: auth.info.email}
    |> ensure_db_entries_exist
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end

  defp validate_pass(%{other: %{password: ""}}) do
    {:error, "Password required"}
  end
  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end
  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end
  defp validate_pass(_), do: {:error, "Password Required"}

  defp ensure_db_entries_exist(authed_user) do
    [_, domain] = String.split(authed_user.email, "@")
    query = from org in Organization,
    where: org.domain == ^domain

    org = Repo.one query
    unless org do
      {:ok, org} = Repo.insert(%Organization{domain: domain})
    end

    query = from u in User,
    where: u.username == ^authed_user.email

    user = Repo.one query
    unless user do
      {:ok, user} = Repo.insert(%User{username: authed_user.email,
                                      organization_id: org.id})
    end
    user
  end

end
