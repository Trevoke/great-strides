defmodule GreatStrides.MailController do
  use GreatStrides.Web, :controller

  def create(conn, params) do
    foo = params["headers"]["Subject"]
    bar = if(String.length(params["reply_plain"]) == 0) do
      params["plain"]
    else
      params["reply_plain"]
    end
    date = params["headers"]["Date"]

    render conn, :ok
  end
end
