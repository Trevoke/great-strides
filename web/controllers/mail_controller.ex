defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller
  require Logger

  def create(conn, params) do
    Logger.info "----------"
    foo = params["headers"]["Subject"]
    bar = String.length(params["reply_plain"]) == 0 ? params["plain"] : params["reply_plain"]
    date = params["headers"]["Date"]
    Logger.info "\n#{date}\n#{foo}\n#{bar}"
    Logger.info "----------"
    render conn, :ok
  end
end
