defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller

  alias GreatStrides.Engagement
  alias GreatStrides.User
  alias GreatStrides.Diary

  require Logger

  def create(conn, params) do
    email_regex = ~r/^.*?<?(\w+@\w+\.\w+)>?$/
    author = params["headers"]["From"]
    usable_author = Enum.at(
      Regex.run(email_regex, author) || "",
      0, "")
    Logger.info author
    Logger.info usable_author
    header = params["headers"]["Subject"]
    body = if(String.length(params["reply_plain"]) == 0) do
      params["plain"]
    else
      params["reply_plain"]
    end
    date = params["headers"]["Date"]

    user = Repo.one from u in User, where: u.username == ^usable_author
    if user && user.engagement_id do
      diary_changeset = Diary.changeset(
        %Diary{
          date: date,
          entry: "#{header}\n\t#{body}",
          user_id: user.id,
          engagement_id: user.engagement_id
        })
      Repo.insert(diary_changeset)
    end

    render conn, :ok
  end
end
