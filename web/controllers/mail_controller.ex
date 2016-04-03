defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller
  require Logger

  def create(conn, params) do
    foo = params["headers"]["Subject"]
    bar = params["reply_plain"]
    date = params["headers"]["Date"]
    Logger.info "\n#{date}\n#{foo}\n#{bar}"
    render conn, :ok
  end
end
