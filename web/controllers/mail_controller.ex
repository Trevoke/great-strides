defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller

  alias GreatStrides.Engagement
  alias GreatStrides.User
  alias GreatStrides.Diary

  def create(conn, params) do
    author = params["headers"]["From"]
    header = params["headers"]["Subject"]
    body = if(String.length(params["reply_plain"]) == 0) do
      params["plain"]
    else
      params["reply_plain"]
    end
    date = params["headers"]["Date"]

    user = Repo.one from u in User, where u.username == author
    if user and user.engagement_id do
      diary_changeset = Diary.changeset(
        %Diary{
          date: date,
          entry: "#{header}\n\t#{body}",
          user_id: user.id,
          engagement_id: user.engagement_id
        })
      Repo.insert(changeset)
    end

    render conn, :ok
  end
end
