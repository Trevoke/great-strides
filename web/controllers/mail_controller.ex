defmodule GreatStrides.MailController do
	use GreatStrides.Web, :controller
  require Logger
  require IEx

  def create(conn, params) do
    foo = "#{params["headers"]["Subject"]}"
    bar = "#{params["reply_plain"]}"
    Logger.info "\n#{foo}\n#{bar}"
    render conn, :ok
  end
end
