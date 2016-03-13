defmodule GreatStrides.PageController do
  use GreatStrides.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
