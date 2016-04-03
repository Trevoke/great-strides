defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller
  require Logger

  def create(conn, params) do
    Logger.info "----------"
    Logger.info params
    Logger.info "----------"
    foo = params["headers"]["Subject"]
    bar = params["reply_plain"]
    date = params["headers"]["Date"]
    Logger.info "\n#{date}\n#{foo}\n#{bar}"
    Logger.info "----------"
    render conn, :ok
  end
end
